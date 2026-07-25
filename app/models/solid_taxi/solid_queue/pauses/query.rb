class SolidTaxi::SolidQueue::Pauses::Query < SolidTaxi::Query
  ORDER_BY = { queue_name: :asc }

  private

  def base_scope
    ::SolidQueue::Pause
  end

  def find_scope
    @scope = base_scope

    add_filter(:like, :queue_name, query_form.queue_name)

    @scope
  end
end
