# encoding: utf-8

# use basic tests
describe file('/etc/systemd/system/node_exporter.service') do
    it { should be_file }
end

describe file('/usr/sbin/node_exporter') do
  it { should be_file }
  it { should be_executable }
end

describe systemd_service('node_exporter') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9100) do
  it { should be_listening }
  its('processes') { should include 'node_exporter' }
end

describe http('http://localhost:9100') do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should include 'text/html' }
  its('body') { should include 'Node Exporter' }
end