module SolidTaxi
  class SolidCache::EntriesController < SolidCache::BaseController
    def index
      @page = SolidTaxi::SolidCache::Entries::Page.new(params)
    end
  end
end
