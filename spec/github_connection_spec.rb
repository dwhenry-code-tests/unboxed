require 'spec_helper'
require 'github_connection'

describe GithubConnection do
  let(:username) { 'ingenia-api' }

  context 'when using the Octokit gem' do
    subject { described_class.new(username) }

  end
end
