require "rails_helper"

RSpec.describe "Global Search", type: :system do
  before { login_as(:admin) }

  it "displays the search page" do
    visit "/admin/search?q=Rails"

    expect(page).to have_content("Rails")
  end

  it "finds articles by title" do
    visit "/admin/search?q=Ruby+on+Rails"

    # Search results show the resource group heading "Articles"
    # Individual records display via record.try(:name) || record.try(:email) || "#ID"
    expect(page).to have_content("Articles")
  end

  it "finds users by name" do
    visit "/admin/search?q=Ana"

    expect(page).to have_content("Ana García")
  end
end
