class CommentResource < IronAdmin::Resource
  belongs_to :article, display: :title

  field :status, type: :badge, colors: { pending: :yellow, approved: :green, rejected: :red }
  field :author_email, type: :email
  field :body, type: :textarea

  searchable :body, :author_name, :author_email

  filter :status, type: :select
  filter :created_at, type: :date_range

  scope :pending, -> { where(status: :pending) }, default: true
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }

  action :approve, icon: "check-circle" do |comment|
    comment.update!(status: :approved)
  end

  action :reject, icon: "x-circle", confirm: true do |comment|
    comment.update!(status: :rejected)
  end

  bulk_action :bulk_approve, icon: "check-circle" do |comments|
    comments.update_all(status: :approved)
  end

  bulk_action :bulk_reject, icon: "x-circle" do |comments|
    comments.update_all(status: :rejected)
  end

  index_fields :id, :author_name, :author_email, :body, :status, :article, :created_at
  form_fields :author_name, :author_email, :body, :status, :article

  preload :article

  menu icon: "chat-bubble-left-right", priority: 3, group: "Community"
end
