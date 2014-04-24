module Velveteen
  class Queue
    DEFAULT_OPTIONS = Configuration.new(durable: true)

    def initialize name, options = {}
      @name = name
      @options = DEFAULT_OPTIONS.deep_merge options
    end

    def push job
      queue.publish job.to_json, type: job.class.to_s, content_type: 'application/json', persistent: true
    end
    alias :<< :push

    private
    def channel
      @channel ||= connection.create_channel
    end

    def connection
      Velveteen.connection
    end

    def queue
      @queue ||= channel.queue(@name, @options)
    end
  end
end
