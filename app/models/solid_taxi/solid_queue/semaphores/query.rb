class SolidTaxi::SolidQueue::Semaphores::Query < SolidTaxi::Query
  ORDER_BY = { expires_at: :asc }

  private

  def base_scope
    ::SolidQueue::Semaphore
  end

  def find_scope
    @scope = base_scope

    add_filter(:like, :key, query_form.key)
    add_filter(:from_number, :value, query_form.value_from)
    add_filter(:to_number, :value, query_form.value_to)
    add_filter(:from_time, :expires_at, query_form.expires_at_from)
    add_filter(:to_time, :expires_at, query_form.expires_at_to)

    @scope
  end
end
