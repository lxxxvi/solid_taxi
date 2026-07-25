module SolidTaxi
  class SolidQueue::ProcessesController < SolidQueue::BaseController
    def index
      @page = SolidTaxi::SolidQueue::Processes::Page.new(params)
    end
  end
end
