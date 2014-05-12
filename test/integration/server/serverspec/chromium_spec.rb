require 'spec_helper'

describe package 'chromium' do
  it { should be_installed }
end

describe user 'pi' do
  it { should be_exist }
end

describe file '/home/pi/runchromium' do
  it { should be_file }
  its(:content) { should match '/usr/bin/chromium --kiosk --incognito' }
end

describe file '/home/pi/.config/lxsession/LXDE/autostart' do
  it { should be_file }
  its(:content) { should match '@~/runchromium' }
end
