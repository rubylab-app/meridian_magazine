require "rails_helper"

RSpec.describe "Authentication", type: :system do
  describe "login page" do
    it "displays all three users with their roles" do
      visit "/login"

      expect(page).to have_content("Ana García")
      expect(page).to have_content("Carlos López")
      expect(page).to have_content("María Torres")
      expect(page).to have_content("admin")
      expect(page).to have_content("editor")
      expect(page).to have_content("author")
    end

    it "redirects to admin panel after login" do
      login_as(:admin)

      expect(page).to have_current_path("/admin")
    end

    it "redirects unauthenticated users to login" do
      visit "/admin"

      expect(page).to have_current_path("/login")
    end
  end

  describe "role-based login" do
    it "allows admin login" do
      login_as(:admin)

      expect(page).to have_current_path("/admin")
    end

    it "allows editor login" do
      login_as(:editor)

      expect(page).to have_current_path("/admin")
    end

    it "allows author login" do
      login_as(:author)

      expect(page).to have_current_path("/admin")
    end
  end
end
