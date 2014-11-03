require 'spec_helper'

require 'github_connection'
require 'github_connection/octokit'

describe GithubConnection::Octokit do
  let(:username) { 'dwhenry' }
  subject { described_class.new(username) }

  context 'ingenia-api user' do
    let(:username) { 'ingenia-api' }
    it 'can return a list of repos' do
      VCR.use_cassette('octokit_repos_one') do
        expect(subject.repositories.map(&:name)).to eq(["documatica", "ingenia_ruby"])
      end
    end
  end

  describe 'repo has greater than paginated number of repositories' do
    let(:username) { 'dwhenry' }

    it 'will return all repositories' do
      VCR.use_cassette('octokit_dwhenry') do
        expect(subject.repositories.count).to eq(40)
      end
    end
  end

  context 'when user is invalid' do
    let(:username) { 'dwhenry-invalid' }

    it 'raise an InvalidUser error' do
      expect {
        VCR.use_cassette('octokit_dwhenry-invalid') do
          subject.repositories
        end
      }.to raise_error(GithubConnection::InvalidUser, 'Invalid User')
    end
  end
end
