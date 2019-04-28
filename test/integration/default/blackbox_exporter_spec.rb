# encoding: utf-8

# use basic tests
describe file('/etc/systemd/system/blackbox_exporter.service') do
    it { should be_file }
end

describe file('/etc/blackbox_exporter.yml') do
    it { should be_file }
end

describe file('/opt/dss/prom/blackbox_exporter/blackbox_exporter') do
  it { should be_file }
  it { should be_executable }
end

describe systemd_service('blackbox_exporter') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9115) do
  it { should be_listening }
  its('processes') { should include 'blackbox_export' }
end

describe http('http://localhost:9115') do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should include 'text/html' }
  its('body') { should include 'Blackbox Exporter' }
end