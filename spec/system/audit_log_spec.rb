require "rails_helper"

RSpec.describe "Audit Log", type: :system do
  before { login_as(:admin) }

  it "displays the audit log page" do
    visit "/admin/audit"

    expect(page).to have_content("Audit")
  end
end
