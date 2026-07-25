class SolidTaxi::SolidQueue::RecurringTasks::Executions::Page < SolidTaxi::Page
  def recurring_task
    @recurring_task ||= ::SolidQueue::RecurringTask.find(params[:recurring_task_id])
  end
end
