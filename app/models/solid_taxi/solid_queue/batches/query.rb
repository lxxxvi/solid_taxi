class SolidTaxi::SolidQueue::Batches::Query < SolidTaxi::Query
  ORDER_BY = { finished_at: :desc, enqueued_at: :desc }

  private

  def base_scope
    ::SolidQueue::Batch
  end

  def find_scope
    @scope = base_scope

    add_filter(:exact, :id, query_form.id)
    add_filter(:like, :active_job_batch_id, query_form.active_job_batch_id)
    add_filter(:like, :description, query_form.description)
    add_filter(:like, :on_finish, query_form.on_finish)
    add_filter(:like, :on_success, query_form.on_success)
    add_filter(:like, :on_failure, query_form.on_failure)
    add_filter(:like, :metadata, query_form.metadata)
    add_filter(:from_number, :total_jobs, query_form.total_jobs_from)
    add_filter(:to_number, :total_jobs, query_form.total_jobs_to)
    add_filter(:from_number, :completed_jobs, query_form.completed_jobs_from)
    add_filter(:to_number, :completed_jobs, query_form.completed_jobs_to)
    add_filter(:from_number, :failed_jobs, query_form.failed_jobs_from)
    add_filter(:to_number, :failed_jobs, query_form.failed_jobs_to)
    add_filter(:from_time, :enqueued_at, query_form.enqueued_at_from)
    add_filter(:to_time, :enqueued_at, query_form.enqueued_at_to)
    add_filter(:from_time, :finished_at, query_form.finished_at_from)
    add_filter(:to_time, :finished_at, query_form.finished_at_to)
    add_filter(:from_time, :failed_at, query_form.failed_at_from)
    add_filter(:to_time, :failed_at, query_form.failed_at_to)

    @scope
  end
end
