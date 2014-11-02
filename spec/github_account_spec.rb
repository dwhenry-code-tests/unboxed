require 'spec_helper'
require 'github_account'

describe GithubAccount do
  context 'when user has a single public repo' do
    let(:github_user) { 'single_repo_user' }

    before do
      allow_any_instance_of(GithubConnection).to receive(:repositories).and_return([{'language' => 'Ruby'}])
    end

    it 'returns the language on the repo' do
      account = described_class.new(github_user)

      expect(account.favourite_language).to eq('Ruby')
    end
  end

  context 'when user account is not valid' do
    let(:github_user) { 'single_repo_user' }

    before do
      allow_any_instance_of(GithubConnection).to receive(:repositories).and_raise(GithubConnection::InvalidUser, 'Invalid User')
    end

    it 'returns the language on the repo' do
      account = described_class.new(github_user)

      expect(account.favourite_language).to eq('Error: Invalid User')
    end
  end
end
