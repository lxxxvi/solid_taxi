class SolidTaxi::SolidQueue::Batches::Executions::Page < SolidTaxi::Page
  def batch
    @batch ||= ::SolidQueue::Batch.find(params[:batch_id])
  end
end
