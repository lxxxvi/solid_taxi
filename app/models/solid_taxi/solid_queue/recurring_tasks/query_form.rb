class SolidTaxi::SolidQueue::RecurringTasks::QueryForm < SolidTaxi::QueryForm
  form_fields(
    :key,
    :schedule,
    :command,
    :class_name,
    :arguments,
    :queue_name,
    :priority_from,
    :priority_to,
    :description
  )
end
