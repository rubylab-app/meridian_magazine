class Page < ApplicationRecord
  has_rich_text :content

  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true
end
