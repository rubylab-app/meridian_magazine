require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "capybara/rspec"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join("spec/fixtures")]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Seed the test database before the suite
  config.before(:suite) do
    Rails.application.load_seed
  end

  # Helper to log in as a specific user
  config.include(Module.new do
    def login_as(role)
      user = User.find_by!(role: role)
      visit "/login"
      find("input[name='user_id'][value='#{user.id}']", visible: false)
        .ancestor("form")
        .find("button[type='submit']")
        .click
    end
  end, type: :system)

  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
