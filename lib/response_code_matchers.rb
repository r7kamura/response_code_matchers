require "response_code_matchers/version"
require "rack"

module ResponseCodeMatchers
  Rack::Utils::SYMBOL_TO_STATUS_CODE.each do |name, code|
    name = name.to_s.gsub("'", "")
    define_method("be_#{name}") do
      ResponseCodeMatcher.new(code.to_s, name)
    end
  end

  class ResponseCodeMatcher
    def initialize(expected, name)
      @expected    = expected
      @description = name.to_s.gsub("_", " ")
    end

    def matches?(response)
      @actual = response.code
      @actual == @expected
    end

    def description
      "be #@description"
    end

    def failure_message
      "expected response code to be #@expected, but #@actual"
    end

    def negative_failure_message
      "expected response code not to be #@expected, but #@actual"
    end
  end
end
