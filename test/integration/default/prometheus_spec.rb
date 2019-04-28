# encoding: utf-8

# use basic tests
describe file('/etc/systemd/system/prometheus.service') do
    it { should be_file }
end

describe file('/opt/dss/prom/prometheus.yml') do
    it { should be_file }
end

describe file('/opt/dss/prom/data') do
    its('type') { should eq :directory }
    it { should be_directory }
end

describe file('/opt/dss/prom/prometheus') do
  it { should be_file }
  it { should be_executable }
end

describe command('/opt/dss/prom/promtool check config /opt/dss/prom/prometheus.yml') do
  its('stdout') { should include "SUCCESS:" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

describe systemd_service('prometheus') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9090) do
  it { should be_listening }
  its('processes') { should include 'prometheus' }
end

describe http('http://localhost:9090/graph') do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should include 'text/html' }
  its('body') { should include 'Prometheus' }
end

