module Velveteen
  class Worker
    include Velveteen

    def self.from_json json
      json = JSON.parse json if json.is_a? String
      worker = self.new

      json.keys.each do |key|
        worker.instance_variable_set :"@#{key}", Hashie::Mash.new(json[key])
      end
      worker
    end
  end
end
