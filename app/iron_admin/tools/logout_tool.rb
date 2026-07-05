# frozen_string_literal: true

module IronAdmin
  module Tools
    class LogoutTool < IronAdmin::Tool
      menu label: "Sign Out", icon: "arrow-right-on-rectangle", priority: 99, group: "Account"
    end
  end
end
