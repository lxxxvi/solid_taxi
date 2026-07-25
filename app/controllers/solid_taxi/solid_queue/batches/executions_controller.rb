module SolidTaxi
  class SolidQueue::Batches::ExecutionsController < SolidQueue::BaseController
    def index
      @page = SolidQueue::Batches::Executions::Page.new(params)
    end
  end
end
