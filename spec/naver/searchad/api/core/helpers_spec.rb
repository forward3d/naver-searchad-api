require 'spec_helper'

describe Naver::Searchad::Api::Core::Helpers do
  subject { Class.new.extend(described_class) }

  describe '#remove_excessive_fslashes_from_url' do
    it 'removes exessive forward slashes from url' do
      result =
        subject.send(:remove_excessive_fslashes_from_url, 'http://test.com//path/')

      expect(result).to eq('http://test.com/path/')
    end
  end
end
