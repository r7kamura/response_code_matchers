require "response_code_matchers/version"
require "rack"

module ResponseCodeMatchers

  def status_name(name)

  end

  Rack::Utils::SYMBOL_TO_STATUS_CODE.each do |name, code|
    name = name.to_s.tap do |t|
      t.gsub!("'", '')
      t.gsub!(/\(.*\)/, '')
      t.gsub!(/\_$/, '')
    end
    define_method("be_#{name}") do
      ResponseCodeMatcher.new(code.to_s, name)
    end
  end

  class ResponseCodeMatcher
    def initialize(expected, name)
      @expected = expected
      @name     = name
    end

    def matches?(response)
      if @valid = response.respond_to?(:code)
        @actual = response.code
        @actual == @expected
      elsif @valid = response.respond_to?(:status)
        @actual = response.status.to_s
        @actual == @expected
      else
        response.__send__(method_name)
      end
    end

    def description
      "be #{human_name}"
    end

    def failure_message
      if @valid
        "expected response code to be #@expected, but #@actual"
      else
        "expected #{method_name} to return true, got false"
      end
    end

    def negative_failure_message
      if @valid
        "expected response code not to be #@expected, but #@actual"
      else
        "expected #{method_name} to return false, got true"
      end
    end

    private

    def method_name
      "#@name?"
    end

    def human_name
      @name.gsub("_", " ")
    end
  end
end
