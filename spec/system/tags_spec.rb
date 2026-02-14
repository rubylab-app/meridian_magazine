require "rails_helper"

RSpec.describe "Tags Management", type: :system do
  before { login_as(:admin) }

  it "lists all tags" do
    visit "/admin/tags"

    expect(page).to have_content("Ruby")
    expect(page).to have_content("Rails")
    expect(page).to have_content("Javascript")
  end

  it "shows tag details" do
    tag = Tag.first
    visit "/admin/tags/#{tag.id}"

    expect(page).to have_content(tag.name)
    expect(page).to have_content(tag.slug)
  end

  it "allows creating a new tag" do
    visit "/admin/tags/new"

    fill_in "Name", with: "Docker"
    fill_in "Slug", with: "docker"
    click_button "Create"

    expect(page).to have_content("Docker")
  end
end
