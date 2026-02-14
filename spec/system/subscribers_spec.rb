require "rails_helper"

RSpec.describe "Subscribers Management", type: :system do
  before { login_as(:admin) }

  it "lists subscribers" do
    visit "/admin/subscribers"

    expect(page).to have_content("Subscribers")
    expect(page).to have_content("alex.rivera@gmail.com")
  end

  it "shows scope tabs for confirmed/unconfirmed" do
    visit "/admin/subscribers"

    expect(page).to have_link("Confirmed")
    expect(page).to have_link("Unconfirmed")
  end

  it "shows subscriber details" do
    subscriber = Subscriber.first
    visit "/admin/subscribers/#{subscriber.id}"

    expect(page).to have_content(subscriber.email)
  end

  it "supports CSV export" do
    visit "/admin/subscribers/export.csv"

    expect(page.response_headers["Content-Type"]).to include("text/csv")
  end

  it "supports JSON export" do
    visit "/admin/subscribers/export.json"

    parsed = JSON.parse(page.body)
    expect(parsed).to be_an(Array)
  end
end
