class SiteSetting < ApplicationRecord
  enum :setting_type, { string: 0, boolean: 1, number: 2 }

  validates :key, presence: true, uniqueness: true
end
