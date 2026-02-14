# frozen_string_literal: true

namespace :demo do
  desc "Reset demo data — truncates all tables and re-seeds"
  task reset: :environment do
    puts "Resetting demo data..."

    # Disable foreign key checks for SQLite
    ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF")

    # Truncate all application tables (preserve schema_migrations)
    tables = ActiveRecord::Base.connection.tables - %w[schema_migrations ar_internal_metadata]
    tables.each do |table|
      ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    end

    ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON")

    # Re-seed
    Rails.application.load_seed

    puts "Demo data reset complete!"
  end
end
