require "response_code_matchers"

RSpec.configure do |config|
  if config.respond_to?(:raise_errors_for_deprecations!)
    config.raise_errors_for_deprecations!
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true if RSpec::Core::Version::STRING < '3'
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include ResponseCodeMatchers
end
