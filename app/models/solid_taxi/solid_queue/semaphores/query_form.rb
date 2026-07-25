class SolidTaxi::SolidQueue::Semaphores::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :key,
    :value_from,
    :value_to,
    :expires_at_from,
    :expires_at_to
  )
end
