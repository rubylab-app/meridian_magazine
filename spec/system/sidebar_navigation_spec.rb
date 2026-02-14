require "rails_helper"

RSpec.describe "Sidebar Navigation", type: :system do
  before { login_as(:admin) }

  it "displays Content section with Articles and Pages" do
    visit "/admin"

    expect(page).to have_content("Content")
    expect(page).to have_link("Articles")
    expect(page).to have_link("Pages")
  end

  it "displays Community section with Comments, Subscribers, and Newsletters" do
    visit "/admin"

    expect(page).to have_content("Community")
    expect(page).to have_link("Comments")
    expect(page).to have_link("Subscribers")
    expect(page).to have_link("Newsletters")
  end

  it "displays Settings section with Categories, Tags, Users, and Site Settings" do
    visit "/admin"

    expect(page).to have_content("Settings")
    expect(page).to have_link("Categories")
    expect(page).to have_link("Tags")
    expect(page).to have_link("Users")
    expect(page).to have_link("Site settings")
  end

  it "navigates to Articles index" do
    visit "/admin"
    click_link "Articles"

    expect(page).to have_current_path("/admin/articles")
  end

  it "navigates to Comments index" do
    visit "/admin"
    click_link "Comments"

    expect(page).to have_current_path("/admin/comments")
  end
end
