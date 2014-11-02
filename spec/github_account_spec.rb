require 'spec_helper'
require 'github_account'

describe GithubAccount do
  context 'when user has a single public repo' do
    let(:github_user) { 'single_repo_user' }

    it 'returns the language on the repo' do
      account = described_class.new(github_user)

      expect(account.favourite_language).to eq('ruby')
    end
  end
end
