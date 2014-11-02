module FavouriteLanguageSelector
  class MostPopularLanguage
    def initialize(repositories)
      @repositories = repositories
    end

    def get
      current_time = Time.now
      language, _ = @repositories
      .group_by(&:language)
      .sort_by do |_, repos|
        [
          repos.count,
          -total_time_since_update(repos, current_time) # sum of time since last updated for all repos (desc)
        ]
      end
      .last

      language
    end

    private

    def total_time_since_update(repos, current_time)
      repos.inject(0.0) do |sum, repo|
        sum + (current_time - repo.updated_at)
      end
    end
  end
end
