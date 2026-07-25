module SolidTaxi
  class SolidQueue::JobsController < SolidQueue::BaseController
    def index
      @page = SolidTaxi::SolidQueue::Jobs::Page.new(params)
    end
  end
end
