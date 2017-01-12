require 'spec_helper'
require 'github_account'

describe GithubAccount do
  let(:connection) { double(:connection) }
  let(:connection_class) { double(:connection_class, new: connection) }

  subject { described_class.new(username, connection: connection_class) }

  context 'when user has a single public repo' do
    let(:username) { 'single_repo_user' }

    before do
      allow(connection).to receive(:repositories).and_return([
        OpenStruct.new('language' => 'Ruby', updated_at: Time.now)
      ])
    end

    it 'returns the language on the repo' do
      expect(subject.favourite_language).to eq('Ruby')
    end
  end

  context 'when user account is not valid' do
    let(:username) { 'single_repo_user' }

    before do
      allow(connection).to receive(:repositories).and_raise(
        GithubConnection::InvalidUser, 'Invalid User'
      )
    end

    it 'returns the language on the repo' do
      expect(subject.favourite_language).to eq(
        'Invalid Github username: single_repo_user'
      )
    end
  end

  context 'when multiple selectors are present' do
    let(:username) { 'lamp' }
    subject do
      described_class.new(
        username,
        selector: ['first_past_the_post', 'most_popular'],
        connection: connection_class
      )
    end

    it 'only queries for the repositories once' do
      allow(connection).to receive(:repositories).once.and_return([
        OpenStruct.new('language' => 'Ruby', updated_at: Time.now)
      ])

      subject.favourite_language
    end
  end

  describe '#valid?' do
    let(:username) { 'username' }

    context 'when repositories are returned' do
      before do
        allow(connection).to receive(:repositories).and_return([])
      end

      it 'is valid' do
        expect(subject).to be_valid
      end

      it 'clears any error messages' do
        subject.valid?
        expect(subject.error).to be_nil
      end
    end

    context 'when Invalid User error is returned when retrieving repositories' do
      before do
        allow(connection).to receive(:repositories).and_raise(
          GithubConnection::InvalidUser, 'Invalid User'
        )
      end

      it 'is invalid' do
        expect(subject).not_to be_valid
      end

      it 'sets the error message' do
        subject.valid?
        expect(subject.error).to eq(
          "Invalid Github username: username"
        )
      end
    end

    context 'when any other error is returned when retrieving repositories' do
      before do
        allow(connection).to receive(:repositories).and_raise(
          StandardError
        )
      end

      it 'is invalid' do
        expect(subject).not_to be_valid
      end

      it 'sets the error message' do
        subject.valid?
        expect(subject.error).to eq(
          "Unknown error accessing github details for: username"
        )
      end
    end
  end
end
