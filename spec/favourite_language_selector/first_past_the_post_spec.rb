require 'spec_helper'
require 'favourite_language_selector/first_past_the_post'
describe FavouriteLanguageSelector::FirstPastThePost do
  let(:with_ruby_laguage) { OpenStruct.new(language: 'Ruby') }
  let(:with_java_language) { OpenStruct.new(language: 'Java') }

  it 'returns the laguage from the first repository passed in' do
    expect(described_class.new([with_ruby_laguage]).get).to eq('Ruby')
  end

  it 'ignores later laguage selections even if more popular' do
    expect(described_class.new([with_ruby_laguage, with_java_language, with_java_language]).get).to eq('Ruby')
  end
end
