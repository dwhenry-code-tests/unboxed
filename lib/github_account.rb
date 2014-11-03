require 'github_connection'
require 'favourite_language_selector/first_past_the_post'
require 'favourite_language_selector/most_popular_language'
require 'favourite_language_selector/multiple_selectors'

class GithubAccount
  SELECTOR_LOOKUP = {
    'first_past_the_post' => FavouriteLanguageSelector::FirstPastThePost,
    'most_popular' => FavouriteLanguageSelector::MostPopularLanguage
  }

  CONNECTION_LOOKUP = {
    'octokit' => GithubConnection::Octokit,
  }

  Library = 'octokit'
  Selector = 'most_popular'


  def initialize(username, options={})
    @library = 'octokit'
    @username = username
    @options = options
  end

  def favourite_language
    favourite_language_selector.get
  rescue => e
    "Error: #{e.message}"
  end

  def valid?
    !!repositories
  rescue
    false
  end

  private

  def repositories
    @repositories ||= connection.repositories
  end

  def connection
    library = @options[:library] || Library
    CONNECTION_LOOKUP.fetch(library).new(@username)
  end

  def favourite_language_selector
    selector = @options[:selector] || Selector
    if selector.is_a?(Array)
      FavouriteLanguageSelector::MultipleSelectors.new(
        repositories,
        selector
      )
    else
      SELECTOR_LOOKUP.fetch(selector).new(repositories)
    end
  end
end
