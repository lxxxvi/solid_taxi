class SolidTaxi::SolidQueue::Jobs::Query < SolidTaxi::Query
  ORDER_BY = { scheduled_at: :desc }

  private

  def base_scope
    ::SolidQueue::Job
  end

  def find_scope
    @scope = base_scope
      .select(%(solid_queue_jobs.*, #{SolidTaxi::SolidQueue::Job::CUSTOM__STATUS_CASE_WHEN_BLOCK} AS custom__status))
      .left_outer_joins(:scheduled_execution, :ready_execution, :claimed_execution, :blocked_execution, :failed_execution)

    add_filter(:like, "solid_queue_jobs.queue_name", query_form.queue_name)
    add_filter(:like, "solid_queue_jobs.class_name", query_form.class_name)
    add_filter(:like, "solid_queue_jobs.arguments", query_form.arguments)
    add_filter(:from_number, "solid_queue_jobs.priority", query_form.priority_from)
    add_filter(:to_number, "solid_queue_jobs.priority", query_form.priority_to)
    add_filter(:like, "solid_queue_jobs.active_job_id", query_form.active_job_id)
    add_filter(:from_time, "solid_queue_jobs.scheduled_at", query_form.scheduled_at_from)
    add_filter(:to_time, "solid_queue_jobs.scheduled_at", query_form.scheduled_at_to)
    add_filter(:from_time, "solid_queue_jobs.finished_at", query_form.finished_at_from)
    add_filter(:to_time, "solid_queue_jobs.finished_at", query_form.finished_at_to)
    add_filter(:like, "solid_queue_jobs.concurrency_key", query_form.concurrency_key)
    if SolidTaxi::SolidQueue.supports_batches?
      add_filter(:exact, "solid_queue_jobs.batch_id", query_form.batch_id)
    end
    add_filter(:like, SolidTaxi::SolidQueue::Job::CUSTOM__STATUS_CASE_WHEN_BLOCK, query_form.custom__status)

    @scope
  end
end
