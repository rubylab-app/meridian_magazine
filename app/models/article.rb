class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :comments, dependent: :destroy
  has_one_attached :cover_image
  has_many_attached :gallery

  enum :status, { draft: 0, published: 1, archived: 2 }

  default_scope { where(deleted_at: nil) }

  validates :title, presence: true
  validates :body, presence: true
end
