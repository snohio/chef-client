# copyright: 2021, Mike Butler

control 'chef-client' do
  impact 0.7
  title 'Run the chef-client every 5 minutes'

  if os.windows?
    describe windows_task('chef-client') do
      it { should exist }
      it { should be_enabled }
    end
    describe package('Chef*') do
      it { should be_installed }
      its('version') { should cmp >= '17' }
    end
  elsif os.darwin?
# THESE ARE BROKEN WHEN RUNNING INSPEC AGAINST THE SERVER OUTSIDE OF THE CLIENT RUN
#    describe launchd_service('chef.restarter') do
#      it { should be_installed }
#      it { should be_enabled }
#    end
#    describe launchd_service('chef.chef-client') do
#      it { should be_installed }
#      it { should be_enabled }
#    end
    describe file('/Library/LaunchDaemons/com.chef.chef-client.plist') do
      its('content') { should include('<integer>300</integer>') }
    end
    describe bash('pkgutil --pkgs | grep chef | xargs -I% pkgutil --pkg-info=%') do
      its('stdout') { should include('com.getchef.pkg.chef') }
      its('stdout') { should include('version: 18.3.0') }
    end
  else
    describe systemd_service('chef-client.timer') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
    describe file('/etc/systemd/system/chef-client.timer') do
      its('content') { should include('OnUnitActiveSec=5min') }
    end
    describe package('chef') do
      it { should be_installed }
      its('version') { should cmp >= '17' }
    end
  end
end
