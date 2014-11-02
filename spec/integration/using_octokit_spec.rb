require 'spec_helper'
require 'github_account'

describe 'Using Octokit' do
  context 'can retrieve favourite language when only one language in list' do
    let(:github_user) { 'ingenia-api' }

    it 'return most popular language' do
      VCR.use_cassette('octokit_repos_one') do
        account = described_class.new(github_user)

        expect(account.favourite_language).to eq('Ruby')

      end
    end
  end
end
