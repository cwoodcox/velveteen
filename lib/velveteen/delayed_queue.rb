module Velveteen
  class DelayedQueue < Queue
    DEFAULT_OPTIONS = {
      arguments: {
        'x-message-ttl' => (5*60*1000).to_s,
        'x-dead-letter-routing-key' => Velveteen.config.default_queue_name
      }
    }

    def push job
      if queue.consumer_count > 0
        logger.warn "Pushing a message on a delay queue with at least one active consumer. Job will be processed immediately."
      end
      super
    end
  end
end
