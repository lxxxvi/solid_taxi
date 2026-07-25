module SolidTaxi
  class SolidQueue::RecurringTasksController < ApplicationController
    def index
      @recurring_tasks = ::SolidQueue::RecurringTask.all
    end

    def show
      @recurring_task = ::SolidQueue::RecurringTask.find(params[:id])
    end
  end
end
