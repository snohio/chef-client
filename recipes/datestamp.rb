#
# Cookbook:: chef-client
# Recipe:: datestamp
#
# Copyright:: 2022, Mike Butler, All Rights Reserved.

if ::File.exist?(node['chef']['filepath'])
  node.default['chef']['installdate'] = ::File.ctime(node['chef']['filepath'])
  log "Chef Install Date #{node['chef']['installdate']}."
else
  log "Chef Client is not Installed. Path #{node['chef']['filepath']}" do
    level :info
  end
end
