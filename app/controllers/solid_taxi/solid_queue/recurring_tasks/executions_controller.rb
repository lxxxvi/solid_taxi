module SolidTaxi
  class SolidQueue::RecurringTasks::ExecutionsController < ApplicationController
    def index
      @recurring_task = ::SolidQueue::RecurringTask.find(params[:recurring_task_id])
      @recurring_executions = @recurring_task.recurring_executions.joins(:job).includes(:job).all
    end
  end
end
