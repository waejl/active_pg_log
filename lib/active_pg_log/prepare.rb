# frozen_string_literal: true

class Prepare
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
