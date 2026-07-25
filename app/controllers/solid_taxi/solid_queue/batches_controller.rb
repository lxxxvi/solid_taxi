module SolidTaxi
  class SolidQueue::BatchesController < SolidQueue::BaseController
    before_action :redirect_if_batches_not_supported

    def index
      @page = SolidTaxi::SolidQueue::Batches::Page.new(params)
    end

    def show
      @batch = ::SolidQueue::Batch.find(params[:id])
    end

    private

    def redirect_if_batches_not_supported
      return if SolidTaxi::SolidQueue.supports_batches?

      redirect_to solid_queue_root_path
    end
  end
end
