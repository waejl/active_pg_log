# frozen_string_literal: true

module ActivePgLog
  # ActiveLog doc
  module ActiveLog
    def self.included(clazz)
      @active_trigger = ActivePgLog::ActiveTrigger.new(clazz.connection)

      return if @active_trigger.include?("trigger_log_#{clazz.table_name}_insert_update", clazz.table_name)

      clazz.connection.execute(create_log_ddl_trigger(clazz))
    end

    def disable_log_ddl_trigger(clazz)
      clazz.connection.execute("drop trigger if exists trigger_log_#{self.class.table_name}_insert_update on #{self.class.table_name} cascade;")
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
