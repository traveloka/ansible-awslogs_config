# encoding: utf-8

# crontab
describe pip('awscli-cwlogs', '/var/awslogs/bin/pip') do
  it { should be_installed }
end

describe service('awslogs') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

