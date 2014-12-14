#
# Cookbook Name:: darwin-calendar-server
# Recipe:: configure
#
# Copyright 2013, rhodey orbits

template node['darwin']['config_file'] do
  owner  node['darwin']['user']
  mode   0400
  source 'caldavd.plist.erb'
end

template '/etc/init/caldavd.conf' do
  owner  node['darwin']['user']
  mode   0400
  source 'caldavd.conf.erb'
end

template "#{node['darwin']['server_root']}/Data/accounts.xml" do
  owner  node['darwin']['user']
  mode   0755
  source 'accounts.xml.erb'
  helpers(Opscode::CalendarServerHelpers)
end
