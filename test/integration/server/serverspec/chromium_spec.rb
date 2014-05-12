require 'spec_helper'

describe command 'hostname' do
  it { should return_stdout 'tiger-01' }
end

describe package 'chromium' do
  it { should be_installed }
end

describe user 'pi' do
  it { should exist }
end

describe file '/home/pi/display-screen-content/README.md' do
  it { should be_file }
end

describe file '/home/pi/runchromium' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'pi'}
  its(:content) { should match '/usr/bin/chromium --kiosk --incognito' }
end

describe file '/home/pi/.config/lxsession/LXDE/autostart' do
  it { should be_file }
  its(:content) { should match '@~/runchromium' }
end

describe file '/etc/xdg/lxsession/LXDE/autostart' do
  it { should be_file }
  its(:content) { should_not match /xscreensaver/ }
end
