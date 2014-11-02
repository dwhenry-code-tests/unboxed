require 'spec_helper'
require 'favourite_language_selector/most_popular_language'
require 'date'

describe FavouriteLanguageSelector::MostPopularLanguage do
  let(:with_ruby_language) { OpenStruct.new(language: 'Ruby', updated_at: Time.now - 100) }
  let(:with_java_language) { OpenStruct.new(language: 'Java', updated_at: Time.now - 50) }
  let(:with_c_language) { OpenStruct.new(language: 'C', updated_at: Time.now - 75) }

  context 'when more of one language than any other' do
    subject do
      described_class.new([
        with_java_language,
        with_c_language,
        with_ruby_language,
        with_java_language,
        with_ruby_language,
        with_c_language,
        with_ruby_language,
      ])
    end

    it 'selects the language with the most occurrences' do
      expect(subject.get).to eq('Ruby')
    end
  end

  context 'when two language occur the same number of times in the list' do
    subject do
      described_class.new([
        with_java_language,
        with_ruby_language,
        with_java_language,
        with_ruby_language,
        with_java_language,
        with_ruby_language,
      ])
    end

    it 'selects the language with the minimum time since last updated' do
      expect(subject.get).to eq('Java')
    end
  end

end
