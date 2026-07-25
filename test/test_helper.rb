# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [ File.expand_path("fixtures", __dir__) ]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
end

class ActionDispatch::IntegrationTest
  include SolidTaxi::Engine.routes.url_helpers

  def authenticated_in_dummy_app(password: "8sOfPTT3D4sZzAOhO61vYqUGC0itza9o", &)
    env_before = ENV.to_h

    ENV["SOLID_TAXI_ADMIN_PASSWORD"] = password

    yield
  ensure
    ENV.replace(env_before)
  end
end
