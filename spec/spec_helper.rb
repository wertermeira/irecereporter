
require 'active_storage_validations/matchers'
RSpec.configure do |config|
  config.include ActiveStorageValidations::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
