module FavouriteLanguageSelector
  class FirstPastThePost
    def initialize(repositories)
      @repositories = repositories
    end

    def get
      @repositories.first.language
    end
  end
end
