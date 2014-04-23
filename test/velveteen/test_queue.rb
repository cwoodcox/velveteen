require_relative '../test_velveteen'

class TestQueue < Minitest::Test
  def test_push
    q = Minitest::Mock.new
    q.expect :publish, true, [ {some: 'hash'}.to_json, { type: "Hash", content_type: 'application/json', persistent: true }]

    queue = Velveteen::Queue.new 'test'
    queue.instance_variable_set :@queue, q

    queue.push({some: 'hash'})
    q.verify
  end
end
