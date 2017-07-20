require 'spec_helper'

include Naver::Searchad::Api

describe Ad::Service do
  subject(:this) { described_class.new }
  before(:each) do
    this.authorization = Auth.get_application_default
  end
end
