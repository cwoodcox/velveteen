require 'velveteen'
require 'bunny'

require 'minitest'
require 'minitest/mock'

class TestVelveteen < Minitest::Test
  def test_default_queue
    assert_instance_of Velveteen::Queue, Velveteen.default_queue
  end

  def test_connection
    bunny = Minitest::Mock.new

    Bunny.stub :new, bunny do
      bunny.expect :start, true
      Velveteen.connection
      assert bunny.verify
    end
  end
end
