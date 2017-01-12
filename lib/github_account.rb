require 'github_connection'
require 'favourite_language_selector/first_past_the_post'
require 'favourite_language_selector/most_popular_language'
require 'favourite_language_selector/multiple_selectors'

class GithubAccount
  attr_reader :error

  SELECTOR_LOOKUP = {
    'first_past_the_post' => FavouriteLanguageSelector::FirstPastThePost,
    'most_popular' => FavouriteLanguageSelector::MostPopularLanguage
  }

  def initialize(username, selector: 'most_popular', connection: GithubConnection::Octokit)
    @username = username
    @selector = selector
    @connection = connection
  end

  def favourite_language
    if valid?
      favourite_language_selector.get
    else
      error
    end
  end

  def valid?
    repositories
    @error = nil
    true
  rescue GithubConnection::InvalidUser
    @error = "Invalid Github username: #{@username}"
    false
  rescue
    @error = "Unknown error accessing github details for: #{@username}"
    false
  end

  private

  def repositories
    @repositories ||= connection.repositories
  end

  def connection
    @connection.new(@username)
  end

  def favourite_language_selector
    if @selector.is_a?(Array)
      FavouriteLanguageSelector::MultipleSelectors.new(
        repositories,
        @selector
      )
    else
      SELECTOR_LOOKUP.fetch(@selector).new(repositories)
    end
  end
end
