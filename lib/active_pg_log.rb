# frozen_string_literal: true

require 'active_record'
module ActivePgLog
  VERSION = '0.1.0'

  class Configuration
    class << self
      def destroy
        return unless ActiveRecord::Base.connection.tables.include?('active_pg_log_tables')

        ActiveRecord::Base.transaction do
          ActiveRecord::Base.connection.execute('drop table if exists active_pg_log_tables cascade;')
          ActiveRecord::Base.connection.execute('drop function if exists active_pg_loging() cascade;')
        end
      end

      def setup
        return if ActiveRecord::Base.connection.tables.include?('active_pg_log_tables')

        ActiveRecord::Base.connection.transaction do
          ActiveRecord::Base.connection.execute(log_ddl_table)
          ActiveRecord::Base.connection.execute(log_ddl_function)
        end
      end

      def log_ddl_table
        %(
        CREATE TABLE if not exists  active_pg_log_tables(
          id serial not null,
          id_reference integer not null,
          table_name character varying not null,
          user_name character varying not null,
          data text,
          created_at timestamp without time zone default now()
        );
      )
      end

      def log_ddl_function
        %(
        drop function if exists public.active_pg_loging();
        CREATE OR REPLACE function public.active_pg_loging() returns trigger as $$
          DECLARE
            newRecord JSON;
          BEGIN
           if TG_OP = 'INSERT' or TG_OP = 'UPDATE' then
             select row_to_json(NEW.*) into newRecord;
             insert into active_pg_log_tables (id_reference,table_name,user_name,data,created_at) values (NEW.id,TG_TABLE_NAME,current_user,newRecord,now());
           end if;
           return null;
          END;
        $$ language 'plpgsql';
      )
      end
    end
  end

  class ActiveTrigger
    attr_accessor :dados

    def initialize
      @dados = ActiveRecord::Base.connection.select_all(query)
    end

    def include?(trigger_name, table_name)
      return false if @dados.rows.size.zero?

      @dados.select { |e| e['table_name'] == table_name && e['trigger_name'] == trigger_name }.size.positive?
    end

    def query
      %(select event_object_schema as table_schema,
            event_object_table as table_name,
            trigger_schema,
            trigger_name,
            string_agg(event_manipulation, ',') as event,
            action_timing as activation,
            action_condition as condition,
            action_statement as definition
              from information_schema.triggers
              group by 1,2,3,4,6,7,8
              order by table_schema,
                      table_name;
        )
    end
  end

  class ActivePgLogTable < ActiveRecord::Base
  end

  module ActiveLog
    def self.included(clazz)
      @active_trigger = ActivePgLog::ActiveTrigger.new

      return if @active_trigger.include?("trigger_log_#{clazz.table_name}_insert_update", clazz.table_name)

      ActiveRecord::Base.connection.execute(create_log_ddl_trigger(clazz))
    end

    def disable_log_ddl_trigger
      ActiveRecord::Base.connection.execute("drop trigger if exists trigger_log_#{self.class.table_name}_insert_update on #{self.class.table_name} cascade;")
      nil
    end

    def pg_logs
      ActivePgLogTable.where(table_name: self.class.table_name)
    end

    class << self
      def create_log_ddl_trigger(clazz)
        %(
        drop trigger if exists trigger_log_#{clazz.table_name}_insert_update on #{clazz.table_name} cascade;
        CREATE TRIGGER trigger_log_#{clazz.table_name}_insert_update after insert or update on #{clazz.table_name} for each row execute procedure public.active_pg_loging();
      )
      end
    end
  end
end
