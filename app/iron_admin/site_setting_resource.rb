class SiteSettingResource < IronAdmin::Resource
  field :setting_type, type: :badge, colors: { string: :blue, boolean: :purple, number: :teal }

  searchable :key, :description

  filter :setting_type, type: :select

  index_fields :id, :key, :value, :setting_type
  form_fields :key, :value, :description, :setting_type

  deny_actions :create, :destroy

  policy do
    allow :read
    allow :update, if: ->(user) { user.admin? }
  end

  menu icon: "cog-6-tooth", priority: 4, group: "Settings"
end
