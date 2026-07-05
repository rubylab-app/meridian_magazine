module IronAdmin
  module Resources
    class TagResource < IronAdmin::Resource
      searchable :name, :slug

      filter :name, type: :string
      filter :slug, type: :string

      imports :csv, :json
      import_fields :name, :slug
      import_upsert_key :slug

      index_fields :id, :name, :slug
      form_fields :name, :slug
      export_fields :id, :name, :slug, :created_at

      menu icon: "tag", priority: 3, group: "Settings"
    end
  end
end
