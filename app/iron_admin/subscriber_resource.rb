class SubscriberResource < IronAdmin::Resource
  field :email, type: :email
  field :confirmed, type: :boolean

  searchable :email, :name

  filter :confirmed, type: :boolean
  filter :confirmed_at, type: :date_range

  scope :confirmed, -> { where(confirmed: true) }
  scope :unconfirmed, -> { where(confirmed: false) }

  action :confirm, icon: "check-circle" do |subscriber|
    subscriber.update!(confirmed: true, confirmed_at: Time.current)
  end

  bulk_action :bulk_confirm, icon: "check-circle" do |subscribers|
    subscribers.update_all(confirmed: true, confirmed_at: Time.current)
  end

  index_fields :id, :email, :name, :confirmed, :confirmed_at
  form_fields :email, :name, :confirmed

  exports :csv, :json

  menu icon: "user-group", priority: 4, group: "Community"
end
