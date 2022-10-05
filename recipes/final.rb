#
# Cookbook:: chef-client
# Recipe:: final
#
# Copyright:: 2022, Mike Butler, All Rights Reserved.

chef_client_config 'client.rb' do
  node_name node['machinename']
  chef_server_url 'https://snohio.azure.chef-demo.com/organizations/it_devops'
  policy_group 'prod'
  policy_name 'base'
  chef_license 'accept'
  action :create
end

untag('final')
