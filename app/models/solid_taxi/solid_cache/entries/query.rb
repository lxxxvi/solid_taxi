class SolidTaxi::SolidCache::Entries::Query < SolidTaxi::Query
  ORDER_BY = { created_at: :desc, key_hash: :asc }

  private

  def find_scope
    @scope = base_scope

    add_filter(:exact, :key_hash, query_form.key_hash)
    add_filter(:from_number, :byte_size, query_form.byte_size_from)
    add_filter(:to_number, :byte_size, query_form.byte_size_to)
    add_filter(:from_time, :created_at, query_form.created_at_from)
    add_filter(:to_time, :created_at, query_form.created_at_to)

    @scope
  end

  def base_scope
    ::SolidCache::Entry
  end
end
