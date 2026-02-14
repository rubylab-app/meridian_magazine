class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_one_attached :avatar

  enum :role, { author: 0, editor: 1, admin: 2 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
