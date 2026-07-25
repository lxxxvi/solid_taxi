class SolidTaxi::SolidCable::Messages::Query < SolidTaxi::Query
  ORDER_BY = { created_at: :desc, channel_hash: :asc }

  private

  def find_scope
    @scope = base_scope

    add_filter(:exact, :channel_hash, query_form.channel_hash)
    add_filter(:from_time, :created_at, query_form.created_at_from)
    add_filter(:to_time, :created_at, query_form.created_at_to)

    @scope
  end

  def base_scope
    ::SolidCable::Message
  end
end
