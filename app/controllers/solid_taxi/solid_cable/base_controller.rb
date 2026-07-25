class SolidTaxi::SolidCable::BaseController < SolidTaxi::ApplicationController
  before_action :redirect_if_solid_cable_not_available

  private

  def redirect_if_solid_cable_not_available
    return if SolidTaxi::SolidCable.present?

    redirect_to root_path
  end
end
