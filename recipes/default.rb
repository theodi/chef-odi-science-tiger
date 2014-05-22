include_recipe 'chef-client'
include_recipe 'odi-users'
include_recipe 'odi-apt'
include_recipe 'git'
include_recipe 'hostname'

package 'lightdm' do
  action :install
end

package 'chromium' do
  action :install
end

service 'lightdm' do
  action :start
end

template '/boot/config.txt' do
  source 'config.txt.erb'
  owner 'root'
  variables(
    horizontal_overscan: node['overscan']['horizontal'],
    vertical_overscan: node['overscan']['vertical']
  )
end

git '/home/pi/display-screen-content' do
  repository node['content_repo']
  user 'pi'
  action :sync
  notifies :restart, 'service[lightdm]', :delayed
end

template '/home/pi/runbrowser' do
  source 'runbrowser.erb'
  mode '0755'
  owner 'pi'
  variables(
    hostname: Chef::Config[:node_name]
  )
  notifies :restart, 'service[lightdm]', :delayed
end

directory '/home/pi/.config/midori' do
  action :create
  recursive true
  owner 'pi'
end

template '/home/pi/.config/midori/config' do
  source 'midori/config.erb'
  mode '0755'
  owner 'pi'
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

directory '/etc/lightdm' do
  action :create
  recursive true
  owner 'root'
end

template '/etc/lightdm/lightdm.conf' do
  source 'lightdm.conf.erb'
  owner 'root'
end
