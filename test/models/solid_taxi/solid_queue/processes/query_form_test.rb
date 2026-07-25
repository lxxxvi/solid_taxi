require "test_helper"

class SolidTaxi::SolidQueue::Processes::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        kind: "process-kind",
        last_heartbeat_at_from: "2000-02-03T12:00",
        last_heartbeat_at_to: "2000-02-03T13:00",
        supervisor_id: "1340",
        pid: "8340",
        hostname: "process-hostname",
        metadata: "process-metadata",
        name: "process-name"
      }
    )

    SolidTaxi::SolidQueue::Processes::Page.new(params).query_form.tap do |query_form|
      assert_equal "process-kind", query_form.kind
      assert_equal "2000-02-03T12:00", query_form.last_heartbeat_at_from
      assert_equal "2000-02-03T13:00", query_form.last_heartbeat_at_to
      assert_equal "1340", query_form.supervisor_id
      assert_equal "8340", query_form.pid
      assert_equal "process-hostname", query_form.hostname
      assert_equal "process-metadata", query_form.metadata
      assert_equal "process-name", query_form.name
    end
  end
end
