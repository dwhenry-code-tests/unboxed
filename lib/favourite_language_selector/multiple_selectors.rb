module FavouriteLanguageSelector
  class MultipleSelectors
    def initialize(repositories, selectors)
      @repositories = repositories
      @selectors = selectors
    end

    def get
      @selectors.each_with_object({}) do |selector, hash|
        hash[selector] = GithubAccount::SELECTOR_LOOKUP.fetch(selector).new(@repositories).get
      end
    end
  end
end
