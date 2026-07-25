module SolidTaxi
  class SolidQueue::PausesController < SolidQueue::BaseController
    def index
      @page = SolidTaxi::SolidQueue::Pauses::Page.new(params)
    end
  end
end
