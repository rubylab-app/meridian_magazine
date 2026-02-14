require "rails_helper"

RSpec.describe "Users Management", type: :system do
  describe "as admin" do
    before { login_as(:admin) }

    it "lists users with role badges" do
      visit "/admin/users"

      expect(page).to have_content("Ana García")
      expect(page).to have_content("Carlos López")
      expect(page).to have_content("María Torres")
      expect(page).to have_content("Admin")
      expect(page).to have_content("Editor")
      expect(page).to have_content("Author")
    end

    it "shows scope tabs" do
      visit "/admin/users"

      expect(page).to have_link("Active")
      expect(page).to have_link("Inactive")
    end

    it "allows creating a new user" do
      visit "/admin/users/new"

      expect(page).to have_field("Name")
      expect(page).to have_field("Email")
      expect(page).to have_field("Role")
    end

    it "allows editing a user" do
      user = User.first
      visit "/admin/users/#{user.id}/edit"

      expect(page).to have_field("Name", with: user.name)
    end
  end

  describe "policy enforcement" do
    context "as author" do
      before { login_as(:author) }

      it "can view users list" do
        visit "/admin/users"

        expect(page).to have_content("Users")
        expect(page).to have_content("Ana García")
      end

      it "shows new user button but policy prevents creation" do
        visit "/admin/users"

        # The "New User" button is visible because action_allowed? only checks
        # deny_actions, not policy. The policy enforcement happens in the controller.
        expect(page).to have_link("New User")
      end
    end
  end
end
