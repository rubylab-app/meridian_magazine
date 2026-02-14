class ArticleResource < IronAdmin::Resource
  belongs_to :user, autocomplete: true, display: :name
  belongs_to :category, display: :name
  has_many :comments

  field :status, type: :badge, colors: { draft: :yellow, published: :green, archived: :gray }
  field :featured, type: :boolean
  field :excerpt, type: :textarea
  field :body, type: :rich_text
  field :cover_image, type: :file
  field :gallery, type: :files

  searchable :title, :body, :excerpt

  filter :status, type: :select
  filter :category_id, type: :select
  filter :featured, type: :boolean
  filter :published_at, type: :date_range

  scope :draft, -> { where(status: :draft) }
  scope :published, -> { where(status: :published) }
  scope :archived, -> { where(status: :archived) }
  scope :featured, -> { where(featured: true) }

  action :publish, icon: "check-circle", confirm: true do |article|
    article.update!(status: :published, published_at: Time.current)
  end

  action :archive, icon: "archive-box", confirm: true do |article|
    article.update!(status: :archived)
  end

  action :feature, icon: "star" do |article|
    article.update!(featured: !article.featured)
  end

  bulk_action :publish, icon: "check-circle" do |articles|
    articles.update_all(status: :published, published_at: Time.current)
  end

  bulk_action :archive, icon: "archive-box" do |articles|
    articles.update_all(status: :archived)
  end

  index_fields :id, :title, :status, :category, :user, :featured, :published_at
  form_fields :title, :excerpt, :body, :status, :featured, :published_at, :user, :category, :cover_image, :gallery
  export_fields :id, :title, :status, :category, :user, :published_at, :created_at

  preload :user, :category

  menu icon: "document-text", priority: 1, group: "Content"
end
