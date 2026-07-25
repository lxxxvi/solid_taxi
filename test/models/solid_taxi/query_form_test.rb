require "test_helper"

class SolidTaxi::QueryFormTest < ActiveSupport::TestCase
  test "#model_name" do
    with_params do |query_form|
      assert_instance_of ActiveModel::Name, query_form.model_name
      assert_equal "Query", query_form.model_name.name
    end
  end

  test "#any_queries?" do
    with_params(query: { queue_name: "default" }) do |query_form|
      assert query_form.any_queries?
    end

    with_params(query: { queue_name: nil }) do |query_form|
      refute query_form.any_queries?
    end

    with_params(query: { queue_name: "" }) do |query_form|
      refute query_form.any_queries?
    end

    with_params(query: { unknown_field: "should-not-affect" }) do |query_form|
      refute query_form.any_queries?
    end

    with_params(query: { queue_name: "default", unknown_field: "should-not-affect" }) do |query_form|
      assert query_form.any_queries?
    end

    with_params do |query_form|
      refute query_form.any_queries?
    end

    with_params(anything: :else) do |query_form|
      refute query_form.any_queries?
    end
  end

  private

  def with_params(**args, &)
    ActionController::Parameters.new(args).then do |params|
      yield SolidTaxi::SolidQueue::Jobs::Page.new(params).query_form
    end
  end
end
