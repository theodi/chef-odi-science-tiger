include_recipe 'chef-client'
include_recipe 'odi-users'
include_recipe 'chromium'
include_recipe 'git'
include_recipe 'hostname'

git '/home/pi/display-screen-content' do
  repository 'https://github.com/theodi/display-screen-content.git'
  action :sync
end

template '/home/pi/runchromium' do
  source 'runchromium.erb'
  mode '0755'
  owner 'pi'
  variables(
    hostname: Chef::Config[:node_name]
  )
end

directory '/home/pi/.config/lxsession/LXDE' do
  action :create
  recursive true
  owner 'pi'
end

template '/home/pi/.config/lxsession/LXDE/autostart' do
  source 'autostart.erb'
  owner 'pi'
end

directory '/etc/xdg/lxsession/LXDE' do
  action :create
  recursive true
  owner 'root'
end

file '/etc/xdg/lxsession/LXDE/autostart' do
  action :create
  owner 'root'
  content '# this file has been blanked out by chef'
end
