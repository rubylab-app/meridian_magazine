class TagResource < IronAdmin::Resource
  searchable :name, :slug

  index_fields :id, :name, :slug
  form_fields :name, :slug

  menu icon: "tag", priority: 3, group: "Settings"
end
