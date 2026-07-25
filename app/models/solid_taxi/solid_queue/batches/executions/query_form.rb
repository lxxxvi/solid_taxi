class SolidTaxi::SolidQueue::Batches::Executions::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :job__id,
    :job__queue_name,
    :job__class_name,
    :job__arguments,
    :job__priority_from,
    :job__priority_to,
    :job__active_job_id,
    :job__scheduled_at_from,
    :job__scheduled_at_to,
    :job__finished_at_from,
    :job__finished_at_to,
    :job__concurrency_key,
    :job__custom__status
  )
end
