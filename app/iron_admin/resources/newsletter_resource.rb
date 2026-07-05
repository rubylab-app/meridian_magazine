module IronAdmin
  module Resources
    class NewsletterResource < IronAdmin::Resource
      field :status, type: :badge, colors: { draft: :yellow, scheduled: :blue, sent: :green }
      field :body, type: :textarea
      field :sponsorship_amount, type: :currency, options: { symbol: "$", precision: 2 }

      searchable :subject

      filter :subject, type: :string
      filter :status, type: :select
      filter :recipients_count, type: :number
      filter :sent_at, type: :date_range

      scope :draft, -> { where(status: :draft) }
      scope :scheduled, -> { where(status: :scheduled) }
      scope :sent, -> { where(status: :sent) }

      action :schedule,
             icon: "clock",
             form_fields: [
               action_field(:send_at, type: :datetime, label: "Schedule for"),
             ] do |newsletter, params|
        newsletter.update!(status: :scheduled, sent_at: parse_time(params[:send_at]))
      end

      action :send_now,
             icon: "paper-airplane",
             confirm: true,
             confirm_message: "Send this newsletter to confirmed subscribers?",
             form_fields: [
               action_field(:audience, type: :select, options: %w[confirmed all], default: "confirmed"),
             ] do |newsletter, params|
        scope = params[:audience] == "all" ? Subscriber.all : Subscriber.where(confirmed: true)
        newsletter.update!(status: :sent, sent_at: Time.current, recipients_count: scope.count)
      end

      index_fields :id, :subject, :status, :sponsorship_amount, :recipients_count, :sent_at
      form_fields :subject, :body, :status, :sponsorship_amount

      deny_actions :destroy

      menu icon: "envelope", priority: 5, group: "Community"

      class << self
        private

        def parse_time(value)
          return Time.current if value.blank?

          Time.zone.parse(value.to_s)
        rescue ArgumentError, TypeError
          Time.current
        end
      end
    end
  end
end
