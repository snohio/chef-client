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
  elsif os.macOS?
    describe launchd_service('chef-client') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
    describe package('chef') do
      it { should be_installed }
      its('version') { should cmp >= '17' }
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
