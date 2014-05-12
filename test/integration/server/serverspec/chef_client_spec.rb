require 'spec_helper'

describe 'chef-client' do
  it 'is running' do
    expect(service('chef-client')).to be_running
  end
end
