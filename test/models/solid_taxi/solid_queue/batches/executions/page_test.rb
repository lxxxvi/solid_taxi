require "test_helper"

class SolidTaxi::SolidQueue::Batches::Executions::PageTest < ActiveSupport::TestCase
  test ".new" do
    batch = solid_queue_batches(:successful_batch)

    params = ActionController::Parameters.new(batch_id: batch.id)

    SolidTaxi::SolidQueue::Batches::Executions::Page.new(params).tap do |page|
      assert_equal SolidTaxi::SolidQueue::Batches::Executions::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::Batches::Executions::Query, page.query.class

      assert_equal batch, page.batch
    end
  end
end
