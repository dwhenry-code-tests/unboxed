require 'github_connection'

class GithubAccount
  def initialize(username)

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
    GithubConnection.new
  end
end
