require "rails_helper"

RSpec.describe "IronAdmin 0.6 features", type: :system do
  before { login_as(:admin) }

  it "renders single-record action forms" do
    article = Article.draft.first || Article.first

    visit "/admin/articles/#{article.id}/actions/publish/form"

    expect(page).to have_content("Publish")
    expect(page).to have_content("Publish at")
    expect(page).to have_content("Feature this article")
    expect(page).to have_field("action_form_published_at")
    expect(page).to have_field("action_form_featured")
    expect(page).to have_button("Execute")
  end

  it "renders moderation action forms with required notes" do
    comment = Comment.pending.first || Comment.first

    visit "/admin/comments/#{comment.id}/actions/reject/form"

    expect(page).to have_content("Reject")
    expect(page).to have_content("Rejection note")
    expect(page).to have_field("action_form_reason")
    expect(page).to have_button("Execute")
  end

  it "renders bulk action forms" do
    article = Article.draft.first || Article.first

    visit "/admin/articles/bulk_actions/archive/form?ids[]=#{article.id}"

    expect(page).to have_content("Archive")
    expect(page).to have_content("Archive note")
    expect(page).to have_field("action_form_reason")
    expect(page).to have_css("input[name='ids[]'][value='#{article.id}']", visible: false)
    expect(page).to have_button("Execute")
  end

  it "renders CSV and JSON import screens with importable fields" do
    visit "/admin/subscribers/import"

    expect(page).to have_content("Import Subscribers")
    expect(page).to have_content("Upload CSV or JSON data")
    expect(page).to have_field("file", type: "file")
    expect(page).to have_select("import_format", options: %w[CSV JSON])
    expect(page).to have_content("Importable fields")
    expect(page).to have_content("Email")
    expect(page).to have_content("Confirmed at")
    expect(page).to have_button("Preview")
  end

  it "renders operator-based string and number filters" do
    visit "/admin/articles"

    expect(page).to have_content("Title")
    expect(page).to have_css("select[name='filters[title][op]']", visible: :all)
    expect(page).to have_css("option[value='contains']", text: "Contains", visible: :all)
    expect(page).to have_css("option[value='starts_with']", text: "Starts with", visible: :all)

    visit "/admin/newsletters"

    expect(page).to have_content("Recipients count")
    expect(page).to have_css("select[name='filters[recipients_count][op]']", visible: :all)
    expect(page).to have_css("option[value='greater_than']", text: "Greater than", visible: :all)
    expect(page).to have_css("option[value='between']", text: "Between", visible: :all)
  end

  it "renders nested comment forms inside article editing" do
    article = Article.joins(:comments).first

    visit "/admin/articles/#{article.id}/edit"

    expect(page).to have_content("Comments")
    expect(page).to have_button("Add row")
    expect(page).to have_content("Author name")
    expect(page).to have_content("Author email")
  end

  it "renders the new labeled dashboard widgets and polling configuration" do
    visit "/admin"

    expect(page).to have_content("Published articles per month")
    expect(page).to have_content("Articles by category")
    expect(page).to have_content("Newsletter status")
    expect(IronAdmin.configuration.live_updates).to eq(:polling)
    expect(IronAdmin.configuration.live_poll_interval).to eq(5.seconds)
  end
end
