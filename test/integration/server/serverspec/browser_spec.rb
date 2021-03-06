require 'spec_helper'

describe command 'hostname' do
  it { should return_stdout 'tiger-01' }
end

describe user 'pi' do
  it { should exist }
end

describe package 'chromium' do
  it { should be_installed }
end

describe file '/boot/config.txt' do
  its(:content) { should match /overscan_left=-4/ }
  its(:content) { should match /overscan_right=-4/ }
  its(:content) { should match /overscan_top=-16/ }
  its(:content) { should match /overscan_bottom=-16/ }
end

describe file '/home/pi/display-screen-content/README.md' do
  it { should be_file }
  it { should be_owned_by 'pi' }
end

describe file '/home/pi/runbrowser' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'pi'}
  its(:content) { should match '/home/pi/display-screen-content/tiger-01.csv' }
  its(:content) { should match 'midori -e Fullscreen -a' }
  its(:content) { should match '/usr/bin/chromium --kiosk --incognito' }
end

describe file '/home/pi/.config/lxsession/LXDE/autostart' do
  it { should be_file }
  its(:content) { should match '@~/runbrowser' }
end

describe file '/home/pi/.config/midori/config' do
  it { should be_file }
  it { should be_owned_by 'pi'}
  its(:content) { should match 'enable-html5-local-storage=true' }
end

describe file '/etc/lightdm/lightdm.conf' do
  it { should be_file }
  its(:content) { should match /xserver-command=X -s 0 -nocursor -dpms/ }
end
