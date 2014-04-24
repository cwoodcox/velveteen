module Velveteen
  class Configuration < Hashie::Mash
    include Hashie::Extensions::DeepMerge
  end
end
