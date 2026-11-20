# copyright: 2025, Mike Butler

client_interval = input('client_interval', description: 'Chef Client Interval', value: '5')

control 'chef-client' do
  impact 0.7
  title 'Run the chef-client at regular intervals'

  if os.windows?
    describe windows_task('chef-client') do
      it { should exist }
      it { should be_enabled }
    end
    client_package = if package('Chef Infra Client Enterprise*').installed?
                       'Chef Infra Client Enterprise*'
                     elsif package('Chef Infra Client v*').installed?
                       'Chef Infra Client v*'
                     end
    if client_package
      describe package(client_package) do
        it { should be_installed }
        its('version') { should cmp >= '18.11.11' }
      end
    else
      describe powershell(<<~'POWERSHELL') do
        $path = & hab pkg path chef/chef-infra-client
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        if (-not $path) {
          Write-Error 'Habitat Chef Infra Client package not found'
          exit 1
        }
        ($path -split '[/\\]')[-2]
      POWERSHELL
        its('exit_status') { should eq 0 }
        its('stdout.strip') { should cmp >= '18.11.11' }
      end
    end
  elsif os.darwin?
    # THESE ARE BROKEN WHEN RUNNING INSPEC AGAINST THE SERVER OUTSIDE OF THE CLIENT RUN
    describe launchd_service('chef.restarter') do
      it { should be_installed }
      it { should be_enabled }
    end
    describe launchd_service('chef.chef-client') do
      it { should be_installed }
      it { should be_enabled }
    end
    describe file('/Library/LaunchDaemons/com.chef.chef-client.plist') do
      its('content') { should include('<integer>300</integer>') }
    end
    describe.one do
      describe bash("hab pkg list chef/chef-infra-client | head -n1 | awk -F'/' '{print $3}'") do
        its('stdout.strip') { should cmp >= '18.11.11' }
      end
      describe bash("pkgutil --pkg-info=com.getchef.pkg.chef | awk -F': ' '/version/ {print $2}'") do
        its('stdout.strip') { should cmp >= '18.11.11' }
      end
    end
  else
    describe systemd_service('chef-client.timer') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
    describe file('/etc/systemd/system/chef-client.timer') do
      its('content') { should include("OnUnitActiveSec=#{client_interval}min") }
    end
<<<<<<< HEAD
    describe bash("chef-client --version | awk '{print $NF}'") do
      its('stdout.strip') { should cmp >= '18.11.11' }
=======
    client_package = if package('chef-ice').installed?
                       'chef-ice'
                     elsif package('chef').installed?
                       'chef'
                     end
    if client_package
      describe package(client_package) do
        it { should be_installed }
      end
      describe package(client_package).version.to_s.sub(/-\d[^-]*\z/, '') do
        it { should match(/\A\d+(?:\.\d+){2,}(?:[.-][0-9A-Za-z]+)*\z/) }
        it { should cmp >= '18.11.11' }
      end
    else
      describe bash(<<~'BASH') do
        set -o pipefail
        if [ -x /hab/bin/hab ]; then
          hab=/hab/bin/hab
        else
          hab=hab
        fi
        "$hab" pkg path chef/chef-infra-client | awk -F/ 'NF >= 2 { print $(NF-1) }'
      BASH
        its('exit_status') { should eq 0 }
        its('stdout.strip') { should cmp >= '18.11.11' }
      end
>>>>>>> 82ca526 (1.10.1 final cut)
    end
  end
end
