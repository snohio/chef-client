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
  else
    describe crontab(path: '/etc/cron.d/chef-client') do
      it { should exist }
      its('minutes') { should include '5' }
    end
    describe package('chef') do
      it { should be_installed }
      its('version') { should cmp >= '17' }
    end
  end
end
