module IronAdmin
  module Resources
    class CommentResource < IronAdmin::Resource
      belongs_to :article, display: :title

      field :status, type: :badge, colors: { pending: :yellow, approved: :green, rejected: :red }
      field :author_email, type: :email
      field :body, type: :textarea

      searchable :body, :author_name, :author_email

      filter :author_email, type: :string
      filter :status, type: :select
      filter :created_at, type: :date_range

      scope :pending, -> { where(status: :pending) }, default: true
      scope :approved, -> { where(status: :approved) }
      scope :rejected, -> { where(status: :rejected) }

      action :approve, icon: "check-circle" do |comment|
        comment.update!(status: :approved)
      end

      action :reject,
             icon: "x-circle",
             confirm: true,
             form_fields: [
               action_field(:reason, type: :textarea, required: true, label: "Rejection note"),
             ] do |comment, params|
        note = params[:reason].presence
        body = [comment.body, note && "Moderator note: #{note}"].compact.join("\n\n")
        comment.update!(status: :rejected, body: body)
      end

      bulk_action :bulk_approve, icon: "check-circle" do |comments|
        comments.update_all(status: Comment.statuses[:approved])
      end

      bulk_action :bulk_reject,
                  icon: "x-circle",
                  form_fields: [
                    action_field(:reason, type: :textarea, required: true, label: "Rejection note"),
                  ] do |comments, params|
        note = params[:reason].presence
        comments.find_each do |comment|
          body = [comment.body, note && "Moderator note: #{note}"].compact.join("\n\n")
          comment.update!(status: :rejected, body: body)
        end
      end

      index_fields :id, :author_name, :author_email, :body, :status, :article, :created_at
      form_fields :author_name, :author_email, :body, :status, :article

      preload :article

      menu icon: "chat-bubble-left-right", priority: 3, group: "Community"
    end
  end
end
