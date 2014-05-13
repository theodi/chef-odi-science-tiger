require 'spec_helper'

describe 'chef-client' do
  it 'is running' do
    expect(service('chef-client')).to be_running
  end
end

describe file '/etc/default/chef-client' do
  its(:content) { should match /INTERVAL=300/ }
end
