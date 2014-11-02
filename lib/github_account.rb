require 'github_connection'

class GithubAccount
  def self.library
    @library ||= 'octokit'
  end

  def initialize(username)
    @library = 'octokit'
    @username = username
  end

  def favourite_language
    repositories.first['language']
  rescue => e
    "Error: #{e.message}"
  end

  private

  def repositories
    connection.repositories
  end

  def connection
    {
      'octokit' => GithubConnection::Octokit
    }.fetch(self.class.library).new(@username)
  end
end
