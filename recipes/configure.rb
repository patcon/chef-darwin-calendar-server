#
# Cookbook Name:: darwin-calendar-server
# Recipe:: configure
#
# Copyright 2013, rhodey orbits

template "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/FlockConfig.py" do
  owner  node['darwin']['user']
  mode   0400
  source 'FlockConfig.py.erb'
end

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