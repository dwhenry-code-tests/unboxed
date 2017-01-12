module GithubConnection
  class Octokit
    class MissingBlock < StandardError; end

    def initialize(username)
      # lazy load the gem
      require 'octokit'

      @username = username
    end

    def repositories
      get_all_pages { client.repos(@username, per_page: 5) }
    end

    def client
      @client ||= begin
        if ENV['GITHUB_LOGIN'] && ENV['GITHUB_PASSWORD']
          ::Octokit::Client.new(
            login: ENV['GITHUB_LOGIN'],
            password: ENV['GITHUB_PASSWORD']
          )
        else
          ::Octokit
        end
      end
    end

    private

    def get_all_pages
      old_auto_paginate_setting = ::Octokit.auto_paginate
      ::Octokit.auto_paginate = true
      yield
    rescue ::Octokit::NotFound
      raise GithubConnection::InvalidUser, 'Invalid User'
    ensure
      ::Octokit.auto_paginate = old_auto_paginate_setting
    end
  end
end
# $LOAD_PATH << './lib'; require 'pry'; require 'github_account';  a= GithubAccount.new('guidance-guarantee-programme'); a.favourite_language
