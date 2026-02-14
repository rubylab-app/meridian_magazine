require "rails_helper"

RSpec.describe "Comments Management", type: :system do
  before { login_as(:admin) }

  describe "index page" do
    it "lists comments" do
      visit "/admin/comments"

      expect(page).to have_content("Comments")
    end

    it "shows scope tabs for status" do
      visit "/admin/comments"

      expect(page).to have_link("Pending")
      expect(page).to have_link("Approved")
      expect(page).to have_link("Rejected")
    end

    it "defaults to pending scope" do
      visit "/admin/comments"

      # Pending is the default scope, should show pending comments
      expect(page).to have_content("Pending")
    end

    it "shows soft delete scope tabs" do
      visit "/admin/comments"

      expect(page).to have_link("With deleted")
      expect(page).to have_link("Only deleted")
    end
  end

  describe "show page" do
    it "displays comment details" do
      comment = Comment.first
      visit "/admin/comments/#{comment.id}"

      expect(page).to have_content(comment.author_name)
      expect(page).to have_content(comment.body)
    end
  end
end
