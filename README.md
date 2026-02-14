# Meridian Magazine — IronAdmin Demo Application

A fully functional demo application showcasing [IronAdmin](https://github.com/rubylab-app/iron_admin), a convention-over-configuration admin panel engine for Ruby on Rails.

**Live Demo:** [demo.ironadmin.rubylab.app](https://demo.ironadmin.rubylab.app)

| Ruby | Rails | IronAdmin |
|------|-------|-----------|
| 3.2+ | 8.0+  | Latest    |

---

## Live Demo

Explore the admin panel at **[demo.ironadmin.rubylab.app](https://demo.ironadmin.rubylab.app)**. Pick any of the three pre-configured users to sign in:

| Name           | Email                  | Role     | Permissions                        |
|----------------|------------------------|----------|------------------------------------|
| Ana García     | ana@meridian.com       | `admin`  | Full access (read, create, edit, delete) |
| Carlos López   | carlos@meridian.com    | `editor` | Read, create, and edit             |
| María Torres   | maria@meridian.com     | `author` | Read-only                          |

> Demo data resets periodically — feel free to create, edit, and delete records.

---

## What Is IronAdmin?

IronAdmin is a Rails engine that generates a complete admin panel from your existing models. Instead of writing repetitive CRUD controllers and views, you define **resource classes** with a clean Ruby DSL and IronAdmin handles the rest: data tables, forms, search, filters, exports, and more.

Key principles:

- **Zero boilerplate** — auto-generates UI from your database schema
- **Convention over configuration** — sensible defaults, override only what you need
- **Fully integrated** — works with Active Storage, Action Text, and your existing auth system

Learn more at the [IronAdmin GitHub repository](https://github.com/rubylab-app/iron_admin).

---

## Features Demonstrated

This demo covers the full IronAdmin feature set across 9 resources, a custom dashboard, and a custom tool.

### Resources & Field Types

| Feature | Example | Resource |
|---------|---------|----------|
| Badge fields with color mapping | Status (draft/published/archived) | `ArticleResource` |
| Rich text editing (Action Text) | Article body, page content | `ArticleResource`, `PageResource` |
| File uploads (Active Storage) | Cover image, user avatar | `ArticleResource`, `UserResource` |
| Multiple file uploads | Article gallery | `ArticleResource` |
| Boolean toggles | Featured, active, confirmed | Multiple |
| Email, URL, password fields | User email, website, API token | `UserResource` |
| Color picker | Category color | `CategoryResource` |
| Currency formatting | Sponsorship amount | `NewsletterResource` |
| Textarea | Excerpt, bio, comment body | Multiple |

### Search, Filters & Scopes

| Feature | Example |
|---------|---------|
| Full-text search | Search articles by title, body, and excerpt |
| Select filters | Filter by status, category, role |
| Boolean filters | Filter by featured, active, confirmed |
| Date range filters | Filter by published_at, created_at |
| Scopes with counts | Draft / Published / Archived tabs |
| Default scopes | Users default to "Active" scope |

### Actions & Bulk Actions

| Feature | Example |
|---------|---------|
| Single-record actions | Publish, archive, feature an article |
| Actions with confirmation | "Are you sure?" before publishing |
| Custom confirmation messages | Newsletter send confirmation |
| Bulk actions | Publish/archive multiple articles at once |

### Dashboard, Auth & More

| Feature | Example |
|---------|---------|
| Dashboard metrics | Total articles, subscribers, pending comments |
| Dashboard charts (bar & pie) | Articles per month, articles by category |
| Recent records widget | Latest articles, pending comments |
| Policy-based authorization | Role-based access (admin/editor/author) |
| Theme customization | Dark indigo sidebar theme |
| Menu groups & icons | Content, Community, Settings groups |
| Audit logging | Track all admin actions |
| CSV & JSON exports | Export subscribers |
| Association autocomplete | Author selection on articles |
| Soft deletes | Articles and comments with `deleted_at` |
| Custom tools | Sign Out tool in sidebar |
| Deny actions | Prevent deleting newsletters or site settings |

---

## Getting Started

Follow these steps to integrate IronAdmin into your own Rails app.

### 1. Install the Gem

Add IronAdmin to your `Gemfile`:

```ruby
gem "iron_admin"
```

Run bundler:

```bash
bundle install
```

### 2. Mount the Engine

In `config/routes.rb`, mount the admin panel at your preferred path:

```ruby
Rails.application.routes.draw do
  mount IronAdmin::Engine => "/admin"
end
```

### 3. Configure Authentication

Create an initializer at `config/initializers/iron_admin.rb`:

```ruby
IronAdmin.configure do |config|
  config.title = "My App Admin"

  # Tell IronAdmin how to verify the user is authenticated
  config.authenticate do |controller|
    controller.redirect_to "/login" unless controller.session[:user_id]
  end

  # Tell IronAdmin how to resolve the current user
  config.current_user do |controller|
    User.find_by(id: controller.session[:user_id])
  end
end
```

### 4. Create Your First Resource

Create a file in `app/iron_admin/` for each model you want to manage. For example, `app/iron_admin/article_resource.rb`:

```ruby
class ArticleResource < IronAdmin::Resource
  # Associations
  belongs_to :user, autocomplete: true, display: :name
  belongs_to :category, display: :name
  has_many :comments

  # Field type customization
  field :status, type: :badge, colors: { draft: :yellow, published: :green, archived: :gray }
  field :featured, type: :boolean
  field :excerpt, type: :textarea
  field :body, type: :rich_text
  field :cover_image, type: :file
  field :gallery, type: :files

  # Search configuration
  searchable :title, :body, :excerpt

  # Filters
  filter :status, type: :select
  filter :category_id, type: :select
  filter :featured, type: :boolean
  filter :published_at, type: :date_range

  # Scopes — appear as tabs above the data table
  scope :draft, -> { where(status: :draft) }
  scope :published, -> { where(status: :published) }
  scope :archived, -> { where(status: :archived) }
  scope :featured, -> { where(featured: true) }

  # Single-record actions
  action :publish, icon: "check-circle", confirm: true do |article|
    article.update!(status: :published, published_at: Time.current)
  end

  action :archive, icon: "archive-box", confirm: true do |article|
    article.update!(status: :archived)
  end

  action :feature, icon: "star" do |article|
    article.update!(featured: !article.featured)
  end

  # Bulk actions
  bulk_action :publish, icon: "check-circle" do |articles|
    articles.update_all(status: :published, published_at: Time.current)
  end

  bulk_action :archive, icon: "archive-box" do |articles|
    articles.update_all(status: :archived)
  end

  # Control which fields appear in each context
  index_fields :id, :title, :status, :category, :user, :featured, :published_at
  form_fields :title, :excerpt, :body, :status, :featured, :published_at, :user, :category, :cover_image, :gallery
  export_fields :id, :title, :status, :category, :user, :published_at, :created_at

  # Eager-load associations for the index view
  preload :user, :category

  # Sidebar menu configuration
  menu icon: "document-text", priority: 1, group: "Content"
end
```

That's it. IronAdmin generates the full CRUD interface — index with pagination, show page, create/edit forms, search, filters, and actions.

### 5. Add Authorization (Optional)

Define policies directly in the resource to control access per role:

```ruby
class UserResource < IronAdmin::Resource
  policy do
    allow :read
    allow :create, :update, if: ->(user) { user.admin? || user.editor? }
    allow :delete, if: ->(user) { user.admin? }
  end
end
```

### 6. Build a Dashboard (Optional)

Create `app/iron_admin/admin_dashboard.rb`:

```ruby
class AdminDashboard < IronAdmin::Dashboard
  metric :total_articles, format: :number do
    Article.count
  end

  metric :total_subscribers, format: :number do
    Subscriber.count
  end

  chart :articles_per_month, type: :bar do
    6.downto(0).each_with_object({}) do |months_ago, data|
      date = months_ago.months.ago
      data[date.strftime("%B %Y")] = Article.published.where(published_at: date.all_month).count
    end
  end

  chart :articles_by_category, type: :pie do
    Category.joins(:articles).group("categories.name").count
  end

  recent :articles, limit: 5
  recent :comments, limit: 5, scope: -> { where(status: :pending) }
end
```

### 7. Customize the Theme (Optional)

Style the admin panel to match your brand:

```ruby
IronAdmin.configure do |config|
  config.theme do |t|
    t.sidebar_bg = "bg-indigo-950"
    t.sidebar_link = "text-indigo-200 hover:text-white"
    t.sidebar_link_hover = "bg-indigo-900 text-white"
    t.btn_primary = "bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-4 rounded-lg shadow-sm"
  end
end
```

---

## Project Structure

```
app/
├── iron_admin/                    # IronAdmin resource definitions
│   ├── admin_dashboard.rb         # Dashboard: metrics, charts, recent records
│   ├── article_resource.rb        # Full-featured: all field types, actions, filters
│   ├── category_resource.rb       # Color picker, has_many association
│   ├── comment_resource.rb        # Default scope, belongs_to, approve/reject actions
│   ├── newsletter_resource.rb     # Currency field, deny_actions, custom confirmation
│   ├── page_resource.rb           # Rich text (Action Text), draft/published scopes
│   ├── site_setting_resource.rb   # Deny create/destroy, admin-only policy
│   ├── subscriber_resource.rb     # CSV/JSON exports, bulk actions
│   ├── tag_resource.rb            # Minimal resource (searchable only)
│   ├── user_resource.rb           # Policy-based auth, password field, file upload
│   └── tools/
│       └── logout_tool.rb         # Custom tool: adds Sign Out to sidebar
├── controllers/
│   └── sessions_controller.rb     # Simple session-based auth for the demo
├── models/                        # Standard Rails models (9 models)
└── views/
    ├── sessions/new.html.erb      # Login screen with role selection
    └── iron_admin/tools/logout/
        └── show.html.erb          # Sign Out tool view

config/
├── initializers/
│   └── iron_admin.rb              # IronAdmin configuration (auth, theme, audit)
└── routes.rb                      # Engine mounting + session routes

db/
├── seeds.rb                       # Realistic demo data (30 articles, 60+ comments, etc.)
└── migrate/                       # 13 migrations
```

---

## Run It Locally

```bash
git clone https://github.com/rubylab-app/meridian_magazine.git
cd meridian_magazine
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000) and pick a user to sign in.

---

## Reset Demo Data

A rake task is included to reset all data back to the seed state:

```bash
bin/rails demo:reset
```

For automated resets (e.g., on a deployed demo), use the included script with cron:

```bash
# Every 6 hours
0 */6 * * * cd /path/to/app && script/reset_demo.sh >> log/reset_demo.log 2>&1
```

---

## License

This demo application is open source under the [MIT License](https://opensource.org/licenses/MIT).

For the IronAdmin gem license, see the [IronAdmin repository](https://github.com/rubylab-app/iron_admin).
