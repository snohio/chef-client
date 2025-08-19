#
# Cookbook:: chef-client
# Recipe:: default
#

include_profile 'chef-client::client-run'

if node['chef']['client']['version'] > node['chef_packages']['chef']['version']
  node.default['chef_client_updater']['version'] = node['chef']['client']['version']
  include_recipe 'chef_client_updater::default'
end

case node['platform_family']

when 'windows'
  chef_client_scheduled_task 'Run Chef Infra Client every 5 minutes' do
    frequency 'minute'
    frequency_modifier node['chef']['client']['interval']
    use_consistent_splay true
    accept_chef_license true
  end

when 'mac_os_x'
  chef_client_launchd 'Setup the Chef Infra Client to run every 5 minutes' do
    interval node['chef']['client']['interval']
    action :enable
    accept_chef_license true
  end
  if tagged?('debug')
    include_recipe 'chef-client::macos'
  end
when 'rhel', 'debian'
  chef_client_cron 'chef_client_run' do
    action :remove
  end

  cron_d 'chef_client_run' do
    action :delete
  end

  chef_client_systemd_timer 'chef-client' do
    interval "#{node['chef']['client']['interval']}min"
    accept_chef_license true
  end
end

include_recipe 'chef-client::datestamp'

if tagged?('final')
  include_recipe 'chef-client::final'
end
