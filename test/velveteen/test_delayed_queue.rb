require_relative '../test_velveteen'

class TestDelayedQueue < Minitest::Test
  def test_queue
    assert_kind_of Velveteen::Queue, Velveteen::DelayedQueue.new('delay.20.minutes')
  end
end
