include_recipe 'chef-client'
include_recipe 'odi-users'
include_recipe 'chromium'

template '/home/pi/runchromium' do
  source 'runchromium.erb'
end

directory '/home/pi/.config/lxsession/LXDE' do
  action :create
  recursive true
end

template '/home/pi/.config/lxsession/LXDE/autostart' do
  source 'autostart.erb'
end
