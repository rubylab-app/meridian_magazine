class Comment < ApplicationRecord
  belongs_to :article

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  default_scope { where(deleted_at: nil) }

  validates :body, presence: true
  validates :author_name, presence: true
  validates :author_email, presence: true
end
