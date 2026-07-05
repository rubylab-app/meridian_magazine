module IronAdmin
  module Resources
    class PageResource < IronAdmin::Resource
      field :status, type: :badge, colors: { draft: :yellow, published: :green }
      field :body, type: :textarea
      field :content, type: :rich_text

      searchable :title, :body

      filter :title, type: :string
      filter :status, type: :select
      filter :position, type: :number

      scope :draft, -> { where(status: :draft) }
      scope :published, -> { where(status: :published) }

      action :publish, icon: "check-circle" do |page|
        page.update!(status: :published)
      end

      index_fields :id, :title, :slug, :status, :position
      form_fields :title, :slug, :body, :status, :position, :content

      menu icon: "document-duplicate", priority: 2, group: "Content"
    end
  end
end
