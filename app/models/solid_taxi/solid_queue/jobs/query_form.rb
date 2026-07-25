class SolidTaxi::SolidQueue::Jobs::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :queue_name,
    :class_name,
    :arguments,
    :priority_from,
    :priority_to,
    :active_job_id,
    :scheduled_at_from,
    :scheduled_at_to,
    :finished_at_from,
    :finished_at_to,
    :concurrency_key,
    :batch_id,
    :custom__status
  )
end
