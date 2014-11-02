require 'spec_helper'
require 'github_connection'

describe GithubConnection do
  let(:username) { }
  context 'when using the Octokit gem' do
    subject { described_class.new(:octokit, username) }

    it 'delegates calls to GithubConnection::Octokit class' do
      expect_any_instance_of(GithubConnection::Octokit).to receive(:repositories)
      subject.repositories
    end

    xit 'can return a list of repos' do
      VCR.use_cassette('octokit-repos') do
        expect(subject.repositories).to eq([])
      end
    end
  end
end
