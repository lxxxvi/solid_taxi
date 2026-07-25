class SolidTaxi::SolidQueue::BaseController < SolidTaxi::ApplicationController
  before_action :redirect_if_solid_queue_not_available

  private

  def redirect_if_solid_queue_not_available
    return if SolidTaxi::SolidQueue.present?

    redirect_to root_path
  end
end
