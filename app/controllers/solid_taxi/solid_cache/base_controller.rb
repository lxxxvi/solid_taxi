class SolidTaxi::SolidCache::BaseController < SolidTaxi::ApplicationController
  before_action :redirect_if_solid_cache_not_available

  private

  def redirect_if_solid_cache_not_available
    return if SolidTaxi::SolidCache.present?

    redirect_to root_path
  end
end
