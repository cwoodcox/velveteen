module Velveteen
  class DelayedQueue < Queue
    attr_accessor :delay

    DEFAULT_OPTIONS = Configuration.new(durable: false)

    def initialize delay, options = {}
      @delay = delay
      options[:arguments] = {
        'x-message-ttl' => delay.to_s,
        'x-dead-letter-routing-key' => Velveteen.config.default_queue_name
      }

      super "delay.#{delay}.milliseconds", DEFAULT_OPTIONS.deep_merge(options)
    end

    def push job
      if queue.consumer_count > 0
        logger.warn "Pushing a job on a delay queue with at least one active consumer. Job will be processed immediately."
      end
      super
    end
  end
end
