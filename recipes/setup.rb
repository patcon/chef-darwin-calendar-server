#
# Cookbook Name:: darwin-calendar-server
# Recipe:: setup
#
# Copyright 2013, rhodey orbits

%w{build-essential libreadline6-dev zlib1g-dev libffi6 libffi-dev libsasl2-dev
libpq5 libpq-dev libplist++1 libplist1 libldap-2.4-2 libldap2-dev python-dev
python-setuptools python-central python-openssl python-dateutil python-xattr
python-epydoc python-kerberos python-ldap python-plist python-memcache python-tz
subversion git python-pip}.each do |pkg|
  apt_package pkg do
    action :install
  end
end

package "curl"

bash "install_python_statsd" do
  user "root"
  code <<-EOH
  sudo pip install python-statsd
  sudo pip install boto
  EOH
end

user node['darwin']['user'] do
  supports :manage_home => true
  home     node['darwin']['home_dir']
end

directory node['darwin']['install_dir'] do
  owner  node['darwin']['user']
  mode   755
  action :create
end

directory node['darwin']['server_root'] do
  owner  node['darwin']['user']
  mode   755
  action :create
end
