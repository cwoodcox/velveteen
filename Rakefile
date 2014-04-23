require "bundler/gem_tasks"

desc "Run all tests in test/"
task :test do
  require 'minitest/autorun'

  Dir.glob('./test/**/test_*.rb').each { |file| require file}
end
