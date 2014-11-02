require 'spec_helper'
require 'github_account'

describe GithubAccount do
  context 'when user has a single public repo' do
    let(:github_user) { 'single_repo_user' }

    before do
      allow_any_instance_of(GithubConnection::Octokit).to receive(:repositories).and_return([OpenStruct.new('language' => 'Ruby', updated_at: Time.now)])
    end

    it 'returns the language on the repo' do
      account = described_class.new(github_user)

      expect(account.favourite_language).to eq('Ruby')
    end
  end

  context 'when user account is not valid' do
    let(:github_user) { 'single_repo_user' }

    before do
      allow_any_instance_of(GithubConnection::Octokit).to receive(:repositories).and_raise(GithubConnection::InvalidUser, 'Invalid User')
    end

    it 'returns the language on the repo' do
      account = described_class.new(github_user)

      expect(account.favourite_language).to eq('Error: Invalid User')
    end
  end

  context 'when multiple selectors are present' do
    let(:github_user) { 'lamp' }
    subject { described_class.new(github_user, selector: ['first_past_the_post', 'most_popular']) }

    it 'only queries for the repositories once' do
      expect_any_instance_of(GithubConnection::Octokit).to receive(:repositories).once
      VCR.use_cassette('ockokit_changing_language') do
        subject.favourite_language
      end
    end

    it 'returns a hash of results (selector => value)' do
      VCR.use_cassette('ockokit_changing_language') do
        expect(subject.favourite_language).to eq(
          'first_past_the_post' => 'JavaScript',
          'most_popular' => 'Ruby',
        )
      end
    end
  end
end
