class SolidTaxi::SolidCache::Entries::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :key, # disabled
    :value, # disabled
    :key_hash,
    :byte_size_from,
    :byte_size_to,
    :created_at_from,
    :created_at_to
  )
end
