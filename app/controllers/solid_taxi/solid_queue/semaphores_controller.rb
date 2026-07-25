module SolidTaxi
  class SolidQueue::SemaphoresController < SolidQueue::BaseController
    def index
      @page = SolidTaxi::SolidQueue::Semaphores::Page.new(params)
    end
  end
end
