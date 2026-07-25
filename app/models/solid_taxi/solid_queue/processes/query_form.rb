class SolidTaxi::SolidQueue::Processes::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :kind,
    :last_heartbeat_at_from,
    :last_heartbeat_at_to,
    :supervisor_id,
    :pid,
    :hostname,
    :metadata,
    :name
  )
end
