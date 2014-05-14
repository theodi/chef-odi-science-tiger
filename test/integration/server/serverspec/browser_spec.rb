require 'spec_helper'

describe command 'hostname' do
  it { should return_stdout 'tiger-01' }
end

describe user 'pi' do
  it { should exist }
end

describe file '/home/pi/display-screen-content/README.md' do
  it { should be_file }
  it { should be_owned_by 'pi' }
end

describe file '/home/pi/runbrowser' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'pi'}
  its(:content) { should match 'cat /home/pi/display-screen-content/tiger-01.csv' }
  its(:content) { should match 'midori -e Fullscreen -a \${DASH}' }
end

describe file '/home/pi/.config/lxsession/LXDE/autostart' do
  it { should be_file }
  its(:content) { should match '@~/runchromium' }
end

describe file '/etc/lightdm/lightdm.conf' do
  it { should be_file }
  its(:content) { should match /xserver-command=X -s 0 -nocursor -dpms/ }
end
