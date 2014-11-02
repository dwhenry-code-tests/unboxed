require 'spec_helper'
require 'github_connection'

describe GithubConnection do
  let(:username) { 'ingenia-api' }

  context 'when using the Octokit gem' do
    subject { described_class.new(username) }

    it 'delegates calls to GithubConnection::Octokit class' do
      expect_any_instance_of(GithubConnection::Octokit).to receive(:repositories)
      subject.repositories
    end

    it 'can return a list of repos' do
      VCR.use_cassette('octokit_repos_one') do
        expect(subject.repositories.count).to eq(2  )
      end
    end

    describe 'repo has greater than paginated number of repositories' do
      let(:username) { 'dwhenry' }

      it 'will return all repositories' do
        VCR.use_cassette('octokit_repos_paginated') do
          expect(subject.repositories.count).to eq(40)
        end
      end
    end
  end
end
