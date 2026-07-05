module IronAdmin
  module Resources
    class CategoryResource < IronAdmin::Resource
      has_many :articles

      field :color, type: :color

      searchable :name, :slug

      filter :name, type: :string
      filter :position, type: :number

      imports :csv, :json
      import_fields :name, :slug, :description, :color, :position
      import_upsert_key :slug

      index_fields :id, :name, :slug, :color, :position
      form_fields :name, :slug, :description, :color, :position
      export_fields :id, :name, :slug, :description, :color, :position, :created_at

      menu icon: "folder", priority: 2, group: "Settings"
    end
  end
end
