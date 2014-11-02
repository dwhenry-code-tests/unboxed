class GithubConnection
  class Octokit
    def initialize(username)
      # lazy load the gem
      require 'octokit'

      @username = username
    end

    def repositories
      repos = ::Octokit.repos(@username)
      while ::Octokit.last_response.rels[:next] do
        additional_repos = ::Octokit.last_response.rels[:next].get.data
        return repos unless (additional_repos.map(&:id) - repos.map(&:id)).any?
        repos += additional_repos
      end
      repos
    end
  end
end
