#
# Cookbook:: chef-client
# Recipe:: default
#
# Copyright:: 2021, Mike Butler, All Rights Reserved.

include_profile 'chef-client::client-run'

if platform?('windows')
  chef_client_scheduled_task 'Run Chef Infra Client every 5 minutes' do
    frequency 'minute'
    frequency_modifier 5
    use_consistent_splay true
    accept_chef_license true
  end
else
  chef_client_cron 'Run Chef Infra Client every 5 minutes' do
    minute '5'
    accept_chef_license true
  end
end

if ::File.exist?('C:\Chef\client.rb')
  node.default['chef']['installdate'] = ::File.ctime('C:\Chef\client.rb')
  log "Chef Install Date #{node['chef']['installdate']}."
elsif ::File.exist?('/etc/chef/client.rb')
  node.default['chef']['installdate'] = ::File.ctime('/etc/chef/client.rb')
  log "Chef Install Date #{node['chef']['installdate']}."
else
  log 'Chef Client is not Installed' do
    level :info
  end
end
