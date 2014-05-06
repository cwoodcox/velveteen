require 'velveteen'
require 'bunny'

require 'minitest'
require 'minitest/mock'

class TestVelveteen < Minitest::Test
  def setup
    Velveteen.configure do |config|
      config.default_queue_name = 'a.queue.name'
      config.default_queue_options = { some: :options }
    end
  end

  def test_default_queue
    queue = Velveteen.default_queue

    assert_instance_of Velveteen::Queue, queue

    assert_equal queue.name, 'a.queue.name'
    assert_equal queue.options[:some], :options
  end

  def test_connection
    bunny = Minitest::Mock.new

    Bunny.stub :new, bunny do
      bunny.expect :start, true
      Velveteen.connection
      assert bunny.verify
    end
  end

  def teardown
    Velveteen.config = nil
  end
end
