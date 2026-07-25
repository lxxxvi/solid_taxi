class SolidTaxi::SolidCable::Messages::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :channel, # disabled
    :payload, # disabled
    :channel_hash,
    :created_at_from,
    :created_at_to
  )
end
