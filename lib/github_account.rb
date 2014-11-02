require 'github_connection'
require 'favourite_language_selector/first_past_the_post'

class GithubAccount
  def self.library
    @library ||= 'octokit'
  end

  def self.selector
    @selector ||= 'most_popular'
  end

  def initialize(username)
    @library = 'octokit'
    @username = username
  end

  def favourite_language
    favourite_language_selector.new(repositories).get
  rescue => e
    "Error: #{e.message}"
  end

  private

  def repositories
    connection.repositories
  end

  def connection
    {
      'octokit' => GithubConnection::Octokit,
    }.fetch(self.class.library).new(@username)
  end

  def favourite_language_selector
    {
      'first_past_the_post' => FavouriteLanguageSelector::FirstPastThePost,
      'most_popular' => FavouriteLanguageSelector::MostPopularLanguage
    }.fetch(self.class.selector)
  end
end
