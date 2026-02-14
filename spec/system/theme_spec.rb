require "rails_helper"

RSpec.describe "Theme Customization", type: :system do
  before { login_as(:admin) }

  it "applies custom sidebar background" do
    visit "/admin"

    expect(page).to have_css(".bg-indigo-950")
  end

  it "applies custom primary button style" do
    visit "/admin/articles"

    expect(page).to have_css(".bg-indigo-600")
  end
end
