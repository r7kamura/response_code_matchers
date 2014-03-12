require "response_code_matchers"

RSpec.configure do |config|
  if config.respond_to?(:raise_errors_for_deprecations!)
    config.raise_errors_for_deprecations!
  end
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include ResponseCodeMatchers
end
