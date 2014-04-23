require 'velveteen/queue'
require 'velveteen/worker'

require 'json'

module Velveteen
  class << self
    def connection
      if @connection.nil? || @connection.closed? # Only connect if we don't have a connection
        logger.warn "RabbitMQ connection lost, reconnecting..." if @connection && @connection.closed?
        logger.info "Connecting to RabbitMQ server #{ENV['CLOUDAMQP_URL']}"

        @connection = Bunny.new ENV['CLOUDAMQP_URL'] || nil
        @connection.start
      end
    end

    def default_queue
      @default_queue ||= Queue.new 'akuma.background'
    end

    def logger
      if defined? Rails
        Rails.logger
      else
        @logger ||= Logger.new STDOUT
      end
    end
  end

  def logger
    Velveteen.logger
  end
end
