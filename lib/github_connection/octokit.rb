module GithubConnection
  class Octokit
    def initialize(username)
      # lazy load the gem
      require 'octokit'

      @username = username
    end

    def repositories
      ::Octokit.repos(@username) + additional_pages
    rescue ::Octokit::NotFound
      raise GithubConnection::InvalidUser, 'Invalid User'
    end

    private

    def additional_pages
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
