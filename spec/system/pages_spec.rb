require "rails_helper"

RSpec.describe "Pages Management", type: :system do
  before { login_as(:admin) }

  it "lists pages" do
    visit "/admin/pages"

    expect(page).to have_content("About Meridian Magazine")
    expect(page).to have_content("Contact Us")
    expect(page).to have_content("Privacy Policy")
  end

  it "shows scope tabs" do
    visit "/admin/pages"

    expect(page).to have_link("Draft")
    expect(page).to have_link("Published")
  end

  it "shows page details" do
    p = Page.find_by!(slug: "about")
    visit "/admin/pages/#{p.id}"

    expect(page).to have_content("About Meridian Magazine")
    expect(page).to have_content("Published")
  end
end
