require "rails_helper"

RSpec.describe "Categories Management", type: :system do
  before { login_as(:admin) }

  it "lists all categories" do
    visit "/admin/categories"

    expect(page).to have_content("Technology")
    expect(page).to have_content("Design")
    expect(page).to have_content("Business")
    expect(page).to have_content("Science")
    expect(page).to have_content("Culture")
    expect(page).to have_content("Lifestyle")
  end

  it "shows category details with related articles" do
    category = Category.find_by!(slug: "technology")
    visit "/admin/categories/#{category.id}"

    expect(page).to have_content("Technology")
    expect(page).to have_content("Articles")
  end

  it "allows creating a new category" do
    visit "/admin/categories/new"

    fill_in "Name", with: "Health"
    fill_in "Slug", with: "health"
    click_button "Create"

    expect(page).to have_content("Health")
  end
end
