require 'github_connection/octokit'

class GithubConnection
  class InvalidUser < StandardError; end

  def initialize(library, username)
    @library = self.class.const_get(library.capitalize).new(username)
  end

  def repositories
    @library.repositories
  end
end
