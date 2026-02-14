require "rails_helper"

RSpec.describe "Newsletters Management", type: :system do
  before { login_as(:admin) }

  it "lists newsletters" do
    visit "/admin/newsletters"

    expect(page).to have_content("Newsletters")
    expect(page).to have_content("Rails Still Matters")
  end

  it "shows scope tabs" do
    visit "/admin/newsletters"

    expect(page).to have_link("Draft")
    expect(page).to have_link("Scheduled")
    expect(page).to have_link("Sent")
  end

  it "shows status badges" do
    visit "/admin/newsletters"

    expect(page).to have_content("Sent")
  end

  it "does not show a delete button (deny_actions :delete)" do
    newsletter = Newsletter.first
    visit "/admin/newsletters/#{newsletter.id}"

    expect(page).not_to have_link("Delete")
    expect(page).not_to have_button("Delete")
  end

  it "shows newsletter details" do
    newsletter = Newsletter.first
    visit "/admin/newsletters/#{newsletter.id}"

    expect(page).to have_content(newsletter.subject)
  end
end
