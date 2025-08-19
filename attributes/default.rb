case node['platform_family']

when 'rhel', 'debian', 'mac_os_x'
  default['chef']['filepath'] = '/etc/chef/client.pem'

when 'windows'
  default['chef']['filepath'] = 'c:\chef\client.pem'

end

default['chef']['client']['version'] = '18.7.10'
default['chef']['client']['interval'] = '5'
default['chef_client_updater']['channel'] = 'stable'
default['chef_client_updater']['version'] = 'latest'

default['audit']['compliance_phase'] = true
default['audit']['reporter'] = 'chef-server-automate', 'cli'
default['audit']['attributes'] = {
  'client_interval' => node['chef']['client']['interval']
}


