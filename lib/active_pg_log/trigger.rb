class ActivePgLog::ActiveTrigger
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
