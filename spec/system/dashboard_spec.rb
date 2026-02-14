require "rails_helper"

RSpec.describe "Dashboard", type: :system do
  before { login_as(:admin) }

  it "displays the dashboard as the admin home page" do
    visit "/admin"

    expect(page).to have_content("Meridian Magazine")
  end

  it "displays metric cards" do
    visit "/admin"

    expect(page).to have_content("Total articles")
    expect(page).to have_content("Published this month")
    expect(page).to have_content("Total subscribers")
    expect(page).to have_content("Pending comments")
  end

  it "displays recent articles section" do
    visit "/admin"

    expect(page).to have_content("Recent Articles")
  end

  it "displays recent comments section" do
    visit "/admin"

    expect(page).to have_content("Recent Comments")
  end
end
