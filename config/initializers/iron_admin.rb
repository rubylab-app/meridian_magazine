IronAdmin.configure do |config|
  config.title = "Meridian Magazine"

  config.per_page = 20
  config.default_sort = :created_at
  config.default_sort_direction = :desc

  # Authentication - simple session-based demo auth
  config.authenticate do |controller|
    controller.redirect_to "/login" unless controller.session[:user_id]
  end

  config.current_user do |controller|
    User.find_by(id: controller.session[:user_id])
  end

  # Audit logging
  config.audit_enabled = true

  # Theme customization - dark indigo sidebar
  config.theme do |t|
    t.main_bg = "bg-gray-100"
    t.sidebar_bg = "bg-indigo-950"
    t.sidebar_title = "text-white font-bold"
    t.sidebar_link = "text-indigo-200 hover:text-white"
    t.sidebar_link_hover = "bg-indigo-900 text-white"
    t.sidebar_group_label = "text-indigo-400 uppercase text-xs font-semibold"

    t.btn_primary = "bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-4 rounded-lg shadow-sm"
    t.btn_secondary = "bg-white hover:bg-gray-50 text-gray-700 font-medium py-2 px-4 rounded-lg border border-gray-300 shadow-sm"
    t.btn_danger = "bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg shadow-sm"

    t.link = "text-indigo-600 hover:text-indigo-800"
    t.scope_active = "bg-indigo-600 text-white"
  end
end
