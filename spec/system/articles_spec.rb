require "rails_helper"

RSpec.describe "Articles Management", type: :system do
  before { login_as(:admin) }

  describe "index page" do
    it "lists articles" do
      visit "/admin/articles"

      expect(page).to have_content("Articles")
      expect(page).to have_content("Why Ruby on Rails Still Matters")
    end

    it "displays status badges" do
      visit "/admin/articles"

      expect(page).to have_content("Published")
    end

    it "shows scope tabs" do
      visit "/admin/articles"

      expect(page).to have_link("Draft")
      expect(page).to have_link("Published")
      expect(page).to have_link("Archived")
      expect(page).to have_link("Featured")
    end

    it "filters by draft scope" do
      visit "/admin/articles?scope=draft"

      expect(page).to have_content("SQLite in Production")
    end

    it "filters by archived scope" do
      visit "/admin/articles?scope=archived"

      expect(page).to have_content("Getting Started with Hotwire")
    end

    it "provides search functionality" do
      visit "/admin/articles"

      expect(page).to have_field(type: "search")
    end

    it "has a new article button" do
      visit "/admin/articles"

      expect(page).to have_link("New Article")
    end
  end

  describe "show page" do
    it "displays article details" do
      article = Article.published.first
      visit "/admin/articles/#{article.id}"

      expect(page).to have_content(article.title)
      expect(page).to have_content("Published")
    end

    it "shows related comments" do
      article = Article.published.joins(:comments).first
      visit "/admin/articles/#{article.id}"

      expect(page).to have_content("Comments")
    end
  end

  describe "new article form" do
    it "renders the create form with expected fields" do
      visit "/admin/articles/new"

      expect(page).to have_field("Title")
      expect(page).to have_field("Body")
      expect(page).to have_field("Status")
    end
  end

  describe "edit article" do
    it "renders the edit form" do
      article = Article.first
      visit "/admin/articles/#{article.id}/edit"

      expect(page).to have_field("Title", with: article.title)
    end
  end

  describe "soft delete features" do
    it "shows with_deleted scope tab" do
      visit "/admin/articles"

      expect(page).to have_link("With deleted")
    end

    it "shows only_deleted scope tab" do
      visit "/admin/articles"

      expect(page).to have_link("Only deleted")
    end
  end

  describe "export" do
    it "exports CSV" do
      visit "/admin/articles/export.csv"

      expect(page.response_headers["Content-Type"]).to include("text/csv")
    end

    it "exports JSON" do
      visit "/admin/articles/export.json"

      expect(page.body).to include("Why Ruby on Rails Still Matters")
    end
  end
end
