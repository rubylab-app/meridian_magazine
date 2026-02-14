class UserResource < IronAdmin::Resource
  has_many :articles

  field :role, type: :badge, colors: { author: :blue, editor: :purple, admin: :red }
  field :email, type: :email
  field :avatar_url, type: :url
  field :active, type: :boolean
  field :bio, type: :textarea
  field :avatar, type: :file
  field :api_token, type: :password

  searchable :name, :email

  filter :role, type: :select
  filter :active, type: :boolean

  scope :active, -> { where(active: true) }, default: true
  scope :inactive, -> { where(active: false) }

  action :deactivate, icon: "no-symbol", confirm: true do |user|
    user.update!(active: false)
  end

  action :activate, icon: "check-circle" do |user|
    user.update!(active: true)
  end

  index_fields :id, :avatar, :name, :email, :role, :active, :website
  form_fields :name, :email, :website, :role, :bio, :active, :avatar, :api_token

  policy do
    allow :read
    allow :create, :update, if: ->(user) { user.admin? || user.editor? }
    allow :delete, if: ->(user) { user.admin? }
  end

  menu icon: "users", priority: 1, group: "Settings"
end
