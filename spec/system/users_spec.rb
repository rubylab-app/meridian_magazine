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

      it "hides the new user button" do
        visit "/admin/users"

        # IronAdmin 0.7 checks the resource policy, not only deny_actions,
        # before rendering the New button.
        expect(page).to have_no_link("New User")
      end

      it "forbids the new user form" do
        visit "/admin/users/new"

        expect(page.status_code).to eq(403)
      end

      it "hides the deactivate action" do
        visit "/admin/users/#{User.find_by(role: :admin).id}"

        expect(page).to have_no_button("Deactivate")
      end
    end

    context "as editor" do
      before { login_as(:editor) }

      it "hides the deactivate action" do
        visit "/admin/users/#{User.find_by(role: :admin).id}"

        expect(page).to have_no_button("Deactivate")
      end
    end

    context "as admin" do
      before { login_as(:admin) }

      it "deactivates a user" do
        user = User.find_by(role: :author)
        visit "/admin/users/#{user.id}"
        click_button "Deactivate"

        expect(user.reload.active).to be(false)
      end
    end
  end
end
