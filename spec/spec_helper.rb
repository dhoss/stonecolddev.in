# This file is copied to spec/ when you run 'rails generate rspec:install'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'factory_girl'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'rake/dsl_definition'
require 'rake'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    :debug => true,
    :inspector => true
  })
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

include ActionDispatch::TestProcess
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/factories/**/*.rb")].each { |f| require f }
ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV['SHOW_SQL']
RSpec.configure do |config|

  config.include Capybara::DSL, type:  :feature
  config.include Features::SessionHelpers, type: :feature

  config.use_transactional_fixtures = false
     
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    FactoryGirl.factories.clear
    FactoryGirl.find_definitions
    DatabaseCleaner.start
    Rails.application.load_seed
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    # Get rid of the linked images
    if Rails.env.test? || Rails.env.cucumber?
      tmp = FactoryGirl.create(:attachment)
      store_path = File.dirname(File.dirname(tmp_url))
      temp_path = tmp.cache_dir
      FileUtils.rm_rf(Dir["#{Rails.root}/public/#{store_path}/[^.]*"])
      FileUtils.rm_rf(Dir["#{temp_path}/[^.]*"])
    end
  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods
end
