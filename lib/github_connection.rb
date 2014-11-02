require 'github_connection/octokit'

class GithubConnection
  class InvalidUser < StandardError; end

  def self.library
    @library ||= 'octokit'
  end

  def initialize(username)
    @library = self.class.const_get(self.class.library.capitalize).new(username)
  end

  def repositories
    @library.repositories
  end
end
