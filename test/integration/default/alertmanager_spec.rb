# encoding: utf-8

# use basic tests
describe file('/etc/systemd/system/alertmanager.service') do
    it { should be_file }
end

describe file('/opt/dss/prom/alertmanager.yml') do
    it { should be_file }
end


describe file('/opt/dss/prom/alertmanager') do
  it { should be_file }
  it { should be_executable }
end

describe systemd_service('alertmanager') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9093) do
  it { should be_listening }
  its('processes') { should include 'alertmanager' }
end

describe http('http://localhost:9093') do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should include 'text/html' }
  its('body') { should include 'defaultCreator' }
end

