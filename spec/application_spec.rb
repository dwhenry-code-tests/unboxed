require "spec_helper"
require_relative "../application"

describe "Web integration", type: :controller do
  describe "the root view" do
    it "has links to the favourite language page" do
      visit "/"
      expect(page).to have_css('a', text: "Find a Github users favourite language")
    end

    it "has links to the design page" do
      visit "/"
      expect(page).to have_css("a", text: "View some nice CSS")
    end
  end

  describe "favourite language" do
    it "will render the favourite language" do
      visit "/favourite"

      fill_in "Username", with: "dwhenry"

      VCR.use_cassette("octokit_dwhenry") do
        click_on "Find favourite language"
      end

      expect(page).to have_content("dwhenry's favourite language is Ruby")
    end

  end
end
