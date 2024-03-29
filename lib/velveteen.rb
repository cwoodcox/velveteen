require 'hashie'
require 'json'

require 'velveteen/configuration'
require 'velveteen/queue'
require 'velveteen/delayed_queue'
require 'velveteen/worker'

module Velveteen
  class << self
    attr_writer :config

    def config
      defaults = { default_queue_name: "", default_queue_options: {}}
      @config ||= Hashie::Mash.new defaults
    end

    def configure &block
      block.call config
    end

    def connection
      if @connection.nil? || @connection.closed? # Only connect if we don't have a connection
        logger.warn "RabbitMQ connection lost, reconnecting..." if @connection && @connection.closed?
        logger.info "Connecting to RabbitMQ server #{ENV['CLOUDAMQP_URL']}"

        @connection = Bunny.new ENV['CLOUDAMQP_URL'] || nil
        @connection.start
      end
      @connection
    end

    def default_queue
      @default_queue ||= Queue.new config.default_queue_name, config.default_queue_options
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
