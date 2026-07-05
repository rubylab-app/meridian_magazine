module IronAdmin
  module Resources
    class ArticleResource < IronAdmin::Resource
      belongs_to :user, autocomplete: true, display: :name
      belongs_to :category, display: :name
      has_many :comments,
               nested: true,
               allow_destroy: true,
               fields: %i[author_name author_email body status]

      field :status, type: :badge, colors: { draft: :yellow, published: :green, archived: :gray }
      field :featured, type: :boolean
      field :excerpt, type: :textarea
      field :body, type: :rich_text
      field :cover_image, type: :file
      field :gallery, type: :files

      searchable :title, :body, :excerpt

      filter :title, type: :string
      filter :status, type: :select
      filter :category_id, type: :select
      filter :featured, type: :boolean
      filter :published_at, type: :date_range

      scope :draft, -> { where(status: :draft) }
      scope :published, -> { where(status: :published) }
      scope :archived, -> { where(status: :archived) }
      scope :featured, -> { where(featured: true) }

      action :publish,
             icon: "check-circle",
             confirm: true,
             form_fields: [
               action_field(:published_at, type: :datetime, label: "Publish at"),
               action_field(:featured, type: :boolean, label: "Feature this article"),
             ] do |article, params|
        published_at = parse_time(params[:published_at])
        article.update!(status: :published, published_at: published_at, featured: truthy?(params[:featured]))
      end

      action :archive,
             icon: "archive-box",
             confirm: true,
             form_fields: [
               action_field(:reason, type: :textarea, required: true, label: "Archive note"),
             ] do |article, params|
        note = params[:reason].presence
        excerpt = [article.excerpt, note && "Archive note: #{note}"].compact.join("\n\n")
        article.update!(status: :archived, excerpt: excerpt)
      end

      action :feature, icon: "star" do |article|
        article.update!(featured: !article.featured)
      end

      bulk_action :publish,
                  icon: "check-circle",
                  form_fields: [
                    action_field(:published_at, type: :datetime, label: "Publish at"),
                    action_field(:featured, type: :boolean, label: "Feature selected articles"),
                  ] do |articles, params|
        articles.update_all(
          status: Article.statuses[:published],
          published_at: parse_time(params[:published_at]),
          featured: truthy?(params[:featured])
        )
      end

      bulk_action :archive,
                  icon: "archive-box",
                  form_fields: [
                    action_field(:reason, type: :textarea, required: true, label: "Archive note"),
                  ] do |articles, params|
        note = params[:reason].presence
        articles.find_each do |article|
          excerpt = [article.excerpt, note && "Archive note: #{note}"].compact.join("\n\n")
          article.update!(status: :archived, excerpt: excerpt)
        end
      end

      index_fields :id, :title, :status, :category, :user, :featured, :published_at
      form_fields :title, :excerpt, :body, :status, :featured, :published_at, :user, :category, :comments,
                  :cover_image, :gallery
      export_fields :id, :title, :status, :category, :user, :featured, :published_at, :created_at

      preload :user, :category

      menu icon: "document-text", priority: 1, group: "Content"

      class << self
        private

        def parse_time(value)
          return Time.current if value.blank?

          Time.zone.parse(value.to_s)
        rescue ArgumentError, TypeError
          Time.current
        end

        def truthy?(value)
          ActiveModel::Type::Boolean.new.cast(value)
        end
      end
    end
  end
end
