require 'yaml'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.filter_run :focus => true  
  
  config.run_all_when_everything_filtered = true

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
end

RSpec::Core::ExampleGroup.class_eval do  
  def self.spec_config
    unless @config
      config_file = File.join(File.dirname(__FILE__), 'config.yml')
      raise "no config for specs (create spec/config.yml)!" unless File.exist? config_file
      @config = YAML.load_file(config_file)
    end
    @config
  end

  def spec_config
    self.class.spec_config
  end
end