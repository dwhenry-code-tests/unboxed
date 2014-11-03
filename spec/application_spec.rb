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

end
