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

if ::File.exist?(node['chef']['filepath'])
  node.default['chef']['installdate'] = ::File.ctime(node['chef']['filepath'])
  log "Chef Install Date #{node['chef']['installdate']}."
else
  log "Chef Client is not Installed. Path #{node['chef']['filepath']}" do
    level :info
  end
end
