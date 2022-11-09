case node['platform_family']

when 'rhel', 'debian'
  default['chef']['filepath'] = '/etc/chef/client.pem'

when 'windows'
  default['chef']['filepath'] = 'c:\chef\client.pem'

end

default['chef']['client']['version'] = '17.10.3'
