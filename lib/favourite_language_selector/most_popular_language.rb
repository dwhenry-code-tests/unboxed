module FavouriteLanguageSelector
  class MostPopularLanguage
    def initialize(repositories)
      @repositories = repositories
    end

    def get
      language, _ = @repositories
      .group_by(&:language)
      .sort_by{|_, repos| repos.count}
      .last

      language
    end
  end
end
