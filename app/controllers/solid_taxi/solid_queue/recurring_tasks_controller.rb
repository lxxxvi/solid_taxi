module SolidTaxi
  class SolidQueue::RecurringTasksController < SolidQueue::BaseController
    def index
      @page = SolidTaxi::SolidQueue::RecurringTasks::Page.new(params)
    end

    def show
      @recurring_task = ::SolidQueue::RecurringTask.find(params[:id])
    end
  end
end
