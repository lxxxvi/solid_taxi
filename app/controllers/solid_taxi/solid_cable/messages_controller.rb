module SolidTaxi
  class SolidCable::MessagesController < SolidCable::BaseController
    def index
      @page = SolidTaxi::SolidCable::Messages::Page.new(params)
    end
  end
end
