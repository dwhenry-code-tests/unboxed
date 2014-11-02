require 'github_connection'

class GithubAccount
  def initialize(username)

  end

  def favourite_language
    connection.repositories
    'ruby'
  rescue => e
    "Error: #{e.message}"
  end

  private

  def connection
    GithubConnection.new
  end
end
