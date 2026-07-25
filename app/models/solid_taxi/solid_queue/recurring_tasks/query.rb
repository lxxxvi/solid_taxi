class SolidTaxi::SolidQueue::RecurringTasks::Query < SolidTaxi::Query
  ORDER_BY = { key: :asc }

  private

  def base_scope
    SolidQueue::RecurringTask
  end

  def find_scope
    @scope = base_scope

    add_filter(:like, :key, query_form.key)
    add_filter(:like, :schedule, query_form.schedule)
    add_filter(:like, :command, query_form.command)
    add_filter(:like, :queue_name, query_form.queue_name)
    add_filter(:like, :class_name, query_form.class_name)
    add_filter(:like, :arguments, query_form.arguments)
    add_filter(:from_number, :priority, query_form.priority_from)
    add_filter(:to_number, :priority, query_form.priority_to)
    add_filter(:like, :description, query_form.description)

    @scope
  end
end
