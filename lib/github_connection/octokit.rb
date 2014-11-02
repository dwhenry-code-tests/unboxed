module GithubConnection
  class Octokit
    def initialize(username)
      # lazy load the gem
      require 'octokit'

      @username = username
    end

    def repositories
      ::Octokit.repos(@username) + get_paginated_results

    rescue ::Octokit::NotFound
      raise GithubConnection::InvalidUser, 'Invalid User'
    end

    private

    def get_paginated_results
      all = []
      if ::Octokit.last_response.rels[:next]
        begin
          next_page = ::Octokit.last_response.rels[:next].get.data
          all += next_page
        end while (next_page.map(&:id) - all.map(&:id)).any?
      end
      all
    end
  end
end
