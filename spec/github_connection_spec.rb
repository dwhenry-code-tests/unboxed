require 'spec_helper'

describe GithubConnection do
  let(:username) { }
  context 'when using the Octokit gem' do
    subject { described_class.new(:octokit, username) }

    it 'can return a list of repos' do
      expect(subject.repositories)
    end
  end
end
