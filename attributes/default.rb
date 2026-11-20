case node['platform_family']

when 'rhel', 'debian', 'mac_os_x', 'suse', 'fedora', 'amazon'
  default['chef']['filepath'] = '/etc/chef/client.pem'

when 'windows'
  default['chef']['filepath'] = 'c:\chef\client.pem'

end

default['chef_client_updater']['license_id'] = 'your-license-id'

default['chef']['client']['version'] = '18.10.17'
default['chef']['client']['interval'] = '5'
default['chef_client_updater']['channel'] = 'stable'
default['chef_client_updater']['version'] = 'latest'

default['audit']['compliance_phase'] = true
default['audit']['reporter'] = 'chef-server-automate', 'cli'
default['audit']['attributes'] = {
  'client_interval' => node['chef']['client']['interval']
}


