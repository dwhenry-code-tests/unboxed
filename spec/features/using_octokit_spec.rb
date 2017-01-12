require 'spec_helper'
require 'github_account'

describe 'Using Octokit' do
  context 'can retrieve favourite language when only one language in list' do
    let(:username) { 'ingenia-api' }

    it 'return most popular language' do
      VCR.use_cassette('octokit_repos_one') do
        account = GithubAccount.new(username)

        expect(account.favourite_language).to eq('Ruby')
      end
    end
  end

  context 'when multiple selectors are present' do
    let(:username) { 'lamp' }

    it 'returns a hash of results (selector => value)' do
      account = GithubAccount.new(username, selector: ['first_past_the_post', 'most_popular'])

      VCR.use_cassette('octokit_lamp') do
        expect(account.favourite_language).to eq(
          'first_past_the_post' => 'JavaScript',
          'most_popular' => 'Ruby',
        )
      end
    end
  end

end
