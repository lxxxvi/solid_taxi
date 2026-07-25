module SolidTaxi
  class SolidQueue::RecurringTasks::ExecutionsController < SolidQueue::BaseController
    def index
      @page = SolidQueue::RecurringTasks::Executions::Page.new(params)
    end
  end
end
