#
# Cookbook Name:: darwin-calendar-server
# Recipe:: patch
#
# Copyright 2013, rhodey orbits

SECURESYNC_PATCHES_DIR = "#{node['darwin']['install_dir']}/darwin-patch"

link "#{node['darwin']['install_dir']}/support/build.sh" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/support/build.sh"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/calendarserver/tap/util.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/calendarserver/tap/util.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/stdconfig.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/stdconfig.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/storebridge.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/storebridge.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/txdav/common/datastore/sql_schema/current.sql" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/txdav/common/datastore/sql_schema/current.sql"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/txdav/common/datastore/sql_tables.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/txdav/common/datastore/sql_tables.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/txdav/common/datastore/sql.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/txdav/common/datastore/sql.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/txdav/base/propertystore/sql.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/txdav/base/propertystore/sql.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/txdav/carddav/datastore/sql.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/txdav/carddav/datastore/sql.py"
  link_type :symbolic
  action    :create
end

directory "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync" do
  owner  node['darwin']['user']
  mode   0600
  action :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/__init__.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/__init__.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/PsqlDirectoryService.py" do
  owner  node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/PsqlDirectoryService.py"
  link_type :symbolic
  action    :create
end

directory "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/model" do
  owner  node['darwin']['user']
  mode   0600
  action :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/model/__init__.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/model/__init__.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/model/FlockAccount.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/model/FlockAccount.py"
  link_type :symbolic
  action    :create
end

directory "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/providers" do
  owner  node['darwin']['user']
  mode   0600
  action :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/providers/__init__.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/providers/__init__.py"
  link_type :symbolic
  action    :create
end

link "#{node['darwin']['install_dir']}/twistedcaldav/directory/securesync/providers/CursorAccountFactory.py" do
  owner     node['darwin']['user']
  to        "#{SECURESYNC_PATCHES_DIR}/twistedcaldav/directory/securesync/providers/CursorAccountFactory.py"
  link_type :symbolic
  action    :create
end