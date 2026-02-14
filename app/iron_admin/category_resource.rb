class CategoryResource < IronAdmin::Resource
  has_many :articles

  field :color, type: :color

  searchable :name, :slug

  index_fields :id, :name, :slug, :color, :position
  form_fields :name, :slug, :description, :color, :position

  menu icon: "folder", priority: 2, group: "Settings"
end
