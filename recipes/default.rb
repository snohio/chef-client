#
# Cookbook:: chef-client
# Recipe:: default
#
# Copyright:: 2022, Mike Butler, All Rights Reserved.

include_profile 'chef-client::client-run'

if node['chef']['client']['version'] > node['chef_packages']['chef']['version']
  include_recipe 'chef_client_updater::default'
end

if platform?('windows')
  chef_client_scheduled_task 'Run Chef Infra Client every 5 minutes' do
    frequency 'minute'
    frequency_modifier 5
    use_consistent_splay true
    accept_chef_license true
  end
else
  chef_client_systemd_timer 'chef-client' do
    interval '5min'
    accept_chef_license true
  end
end

include_recipe 'chef-client::datestamp'

if tagged?('final')
  include_recipe 'chef-client::final'
end
