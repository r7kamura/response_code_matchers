require "response_code_matchers/version"
require "rack"

module ResponseCodeMatchers

  Rack::Utils::SYMBOL_TO_STATUS_CODE.each do |name, code|
    name = name.to_s.tap do |t|
      t.gsub!("'", '')      # remove single quotes
      t.gsub!(/\(.*\)/, '') # remove anything in parentheses
      t.gsub!(/\_$/, '')    # remove trailing underscores
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

    def matches?(obj)
      return obj.__send__(method_name) unless obj.respond_to?(:header) && obj.respond_to?(:body)

      if @valid = obj.respond_to?(:code)
        @actual = obj.code
        @actual == @expected
      elsif @valid = obj.respond_to?(:status)
        @actual = obj.status.to_s
        @actual == @expected
      else
        obj.__send__(method_name)
      end
    end

    def description
      "be #{human_name}"
    end

    def failure_message
      if @valid
        "expected response code to be #@expected, got #@actual"
      else
        "expected #{method_name} to return true, got false"
      end
    end

    def failure_message_when_negated
      if @valid
        "expected response code not to be #@expected, got #@actual"
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
