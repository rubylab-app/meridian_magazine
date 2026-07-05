module IronAdmin
  module Dashboards
    class AdminDashboard < IronAdmin::Dashboard
      metric :total_articles, format: :number, icon: "document-text", live: true do
        Article.unscoped.count
      end

      metric :published_this_month, format: :number, icon: "calendar-days", live: true do
        Article.published.where(published_at: Time.current.beginning_of_month..).count
      end

      metric :total_subscribers, format: :number, icon: "user-group", live: true do
        Subscriber.count
      end

      metric :pending_comments, format: :number, icon: "chat-bubble-left-right", live: true do
        Comment.pending.count
      end

      chart :articles_per_month, type: :bar, label: "Published articles per month", live: true do
        6.downto(0).each_with_object({}) do |months_ago, data|
          date = months_ago.months.ago
          key = date.strftime("%B %Y")
          data[key] = Article.published.where(published_at: date.all_month).count
        end
      end

      chart :articles_by_category, type: :pie, label: "Articles by category", live: true do
        Category.joins(:articles).group("categories.name").count
      end

      chart :newsletter_status, type: :doughnut, label: "Newsletter status", live: true do
        Newsletter.group(:status).count.transform_keys { |status| status.to_s.humanize }
      end

      recent :articles, limit: 5
      recent :comments, limit: 5, scope: -> { where(status: :pending) }
    end
  end
end
