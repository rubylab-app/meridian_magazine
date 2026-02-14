require "rails_helper"

RSpec.describe "Site Settings Management", type: :system do
  describe "as admin" do
    before { login_as(:admin) }

    it "lists all settings" do
      visit "/admin/site_settings"

      expect(page).to have_content("site_name")
      expect(page).to have_content("tagline")
      expect(page).to have_content("maintenance_mode")
    end

    it "does not show a new button (deny_actions :create)" do
      visit "/admin/site_settings"

      expect(page).not_to have_link("New Site Setting")
    end

    it "allows editing a setting" do
      setting = SiteSetting.find_by!(key: "site_name")
      visit "/admin/site_settings/#{setting.id}/edit"

      expect(page).to have_field("Value", with: "Meridian Magazine")
    end

    it "shows setting details" do
      setting = SiteSetting.find_by!(key: "tagline")
      visit "/admin/site_settings/#{setting.id}"

      expect(page).to have_content("tagline")
      expect(page).to have_content(setting.value)
    end
  end

  describe "policy enforcement" do
    context "as author" do
      before { login_as(:author) }

      it "can view site settings" do
        visit "/admin/site_settings"

        expect(page).to have_content("site_name")
      end

      it "does not show edit links" do
        visit "/admin/site_settings"

        expect(page).not_to have_link("Edit")
      end
    end
  end
end
