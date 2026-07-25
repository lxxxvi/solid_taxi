class SolidTaxiAdminController < ApplicationController
  before_action :authenticate!

  private

  def authenticate!
    if ENV["SOLID_TAXI_ADMIN_PASSWORD"] != "8sOfPTT3D4sZzAOhO61vYqUGC0itza9o"
      head :unauthorized
      nil
    end
  end
end
