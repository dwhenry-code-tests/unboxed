require 'spec_helper'
require 'favourite_language_selector/most_popular_language'

describe FavouriteLanguageSelector::MostPopularLanguage do
  context 'when more of one language than any other' do
    let(:with_ruby_language) { OpenStruct.new(language: 'Ruby') }
    let(:with_java_language) { OpenStruct.new(language: 'Java') }
    let(:with_c_language) { OpenStruct.new(language: 'C') }

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

    it 'selects the language with the most occurances' do
      expect(subject.get).to eq('Ruby')
    end
  end

end
