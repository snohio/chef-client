# Policyfile.rb - Describe how you want Chef Infra Client to build your system.

# A name that describes what the system you're building with Chef does.
name 'chef-client'

# Where to find external cookbooks:
# default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'chef-client::default'

# Specify a custom source for a single cookbook:
cookbook 'chef-client', path: '.'
