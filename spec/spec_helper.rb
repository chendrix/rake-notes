require 'bundler/setup'
Bundler.require(:default)

SPEC_PATH = File.expand_path('..', __FILE__)
LIB_PATH = File.expand_path(File.join(SPEC_PATH, '../lib'), __FILE__)

require_relative 'support/exit_with_code'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include(Rake::Notes::CustomMatchers)

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
