class AdminDashboard < IronAdmin::Dashboard
  metric :total_articles, format: :number do
    Article.unscoped.count
  end

  metric :published_this_month, format: :number do
    Article.published.where(published_at: Time.current.beginning_of_month..).count
  end

  metric :total_subscribers, format: :number do
    Subscriber.count
  end

  metric :pending_comments, format: :number do
    Comment.pending.count
  end

  chart :articles_per_month, type: :bar do
    6.downto(0).each_with_object({}) do |months_ago, data|
      date = months_ago.months.ago
      key = date.strftime("%B %Y")
      data[key] = Article.published.where(published_at: date.all_month).count
    end
  end

  chart :articles_by_category, type: :pie do
    Category.joins(:articles).group("categories.name").count
  end

  recent :articles, limit: 5
  recent :comments, limit: 5, scope: -> { where(status: :pending) }
end
