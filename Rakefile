require "rubygems"
require "bundler/setup"


desc "Run all tests"
task :test do
    require_relative "test/spec_helper"
    Dir.glob("./test/**/*_spec.rb") { |file| require file}
end