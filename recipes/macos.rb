#
# Cookbook:: chef-client
# Recipe:: macos
#
# Copyright:: 2023, Mike Butler, All Rights Reserved.

bash 'oahi' do
  code <<-EOH
  ohai
  EOH
  action :run
end

bash 'launchctl list' do
  code <<-EOH
  launchctl list
  EOH
  action :run
  live_stream true
end
