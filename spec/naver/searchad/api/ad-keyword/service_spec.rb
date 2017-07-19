require 'spec_helper'

include Naver::Searchad::Api

describe AdKeyword::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end

  describe '#list_ad_keywords_by_ids' do

  end

  describe '#list_ad_keywords_by_adgroup_id' do
  end

  describe '#list_ad_keywords_by_label_id' do
  end

  describe '#get_ad_keyword' do
  end

  describe '#create_ad_keyword' do
  end

  describe '#update_ad_keyword' do
  end

  describe '#delete_ad_keyword' do
  end
end
