# Policyfile.rb - Describe how you want Chef Infra Client to build your system.

# A name that describes what the system you're building with Chef does.
name 'chef-client'

# Where to find external cookbooks:
default_source :chef_repo, '~/chef-repo/cookbooks' do |s|
  s.preferred_for 'chef-client'
end
default_source :supermarket
default_source :chef_server, 'https://snohio.azure.chef-demo.com/organizations/it_devops'

# run_list: chef-client will run these recipes in the order specified.
run_list 'chef-client::default'
