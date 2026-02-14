class Newsletter < ApplicationRecord
  enum :status, { draft: 0, scheduled: 1, sent: 2 }

  validates :subject, presence: true
  validates :body, presence: true
end
