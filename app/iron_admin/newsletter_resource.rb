class NewsletterResource < IronAdmin::Resource
  field :status, type: :badge, colors: { draft: :yellow, scheduled: :blue, sent: :green }
  field :body, type: :textarea
  field :sponsorship_amount, type: :currency, options: { symbol: "$", precision: 2 }

  searchable :subject

  filter :status, type: :select
  filter :sent_at, type: :date_range

  scope :draft, -> { where(status: :draft) }
  scope :scheduled, -> { where(status: :scheduled) }
  scope :sent, -> { where(status: :sent) }

  action :schedule, icon: "clock" do |newsletter|
    newsletter.update!(status: :scheduled)
  end

  action :send_now, icon: "paper-airplane", confirm: true,
                    confirm_message: "Send this newsletter to all confirmed subscribers?" do |newsletter|
    newsletter.update!(status: :sent, sent_at: Time.current, recipients_count: Subscriber.where(confirmed: true).count)
  end

  index_fields :id, :subject, :status, :sponsorship_amount, :recipients_count, :sent_at
  form_fields :subject, :body, :status, :sponsorship_amount

  deny_actions :destroy

  menu icon: "envelope", priority: 5, group: "Community"
end
