class SolidTaxi::SolidQueue::Processes::Query < SolidTaxi::Query
  ORDER_BY = { pid: :asc }

  private

  def base_scope
    ::SolidQueue::Process
  end

  def find_scope
    @scope = base_scope

    add_filter(:like, :kind, query_form.kind)
    add_filter(:from_time, :last_heartbeat_at, query_form.last_heartbeat_at_from)
    add_filter(:to_time, :last_heartbeat_at, query_form.last_heartbeat_at_to)
    add_filter(:exact, :supervisor_id, query_form.supervisor_id)
    add_filter(:exact, :pid, query_form.pid)
    add_filter(:like, :hostname, query_form.hostname)
    add_filter(:like, :metadata, query_form.metadata)
    add_filter(:like, :name, query_form.name)

    @scope
  end
end
