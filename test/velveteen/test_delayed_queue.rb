require_relative '../test_velveteen'

class TestDelayedQueue < Minitest::Test
  def test_queue
    assert_kind_of Velveteen::Queue, Velveteen::DelayedQueue.new(20*60*1000)
  end

  def test_queue_setup
    mock_channel = Minitest::Mock.new
    mock_channel.expect :queue, true do |name, options|
      assert_equal name, "delay.30000.milliseconds"

      assert_equal options.arguments['x-message-ttl'], '30000'
      assert_equal options.arguments['x-dead-letter-routing-key'], ''
    end

    queue = Velveteen::DelayedQueue.new 30*1000
    queue.instance_variable_set :@channel, mock_channel
    queue.send :queue

    assert mock_channel.verify
  end

  def test_publish
    mock_queue = Minitest::Mock.new
    mock_queue.expect :publish, true, [ String, Hash ]
    mock_queue.expect :consumer_count, 0

    queue = Velveteen::DelayedQueue.new 30*1000
    queue.instance_variable_set :@queue, mock_queue
    queue.push(some_job: 'options')

    assert mock_queue.verify
  end
end
