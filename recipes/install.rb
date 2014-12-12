#
# Cookbook Name:: darwin-calendar-server
# Recipe:: install
#
# Copyright 2013, rhodey orbits

bash "install_dependencies" do
  user "root"
  cwd  node['darwin']['install_dir']
  code "./run -s"
end

bash "install_darwin" do
  user "root"
  cwd  node['darwin']['install_dir']
  code <<-EOH
  ./run -i #{node['darwin']['home_dir']}
  chown #{node['darwin']['user']} -R #{node['darwin']['home_dir']}
  cp -r #{node['darwin']['home_dir']}/usr/local/* /usr/local
  EOH
end

include_recipe 'postgresql::contrib' # required for dblink extension

bash "install-dblink-extension" do
  user "postgres"
  code "echo CREATE EXTENSION IF NOT EXISTS dblink | psql"
end

db_name = node['postgres-darwin']['database']
db_user = node['postgres-darwin']['user']
db_pass = node['postgres-darwin']['password']

db_sql_script = <<HEREDOC
DO
$do$
BEGIN

IF EXISTS (SELECT 1 FROM pg_database WHERE datname = '#{db_name}') THEN
   RAISE NOTICE 'Database already exists';
ELSE
   PERFORM dblink_exec('dbname=' || current_database() -- current db
                      , $$CREATE DATABASE #{db_name}$$);
END IF;

END
$do$
HEREDOC

file "/tmp/create-postgres-db.sql" do
  owner "postgres"
  group "postgres"
  content db_sql_script
end

bash "create-postgres-db" do
  user "postgres"
  code "psql < /tmp/create-postgres-db.sql"
end

# Create postgres user

user_sql_script = <<HEREDOC
DO
$body$
BEGIN
   IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_user
      WHERE  usename = '#{db_user}') THEN

      CREATE ROLE #{db_user} LOGIN ENCRYPTED PASSWORD '#{db_pass}';
      GRANT ALL PRIVILEGES ON DATABASE #{db_name} TO #{db_user};
   END IF;
END
$body$
HEREDOC

file "/tmp/create-postgres-user.sql" do
  owner "postgres"
  group "postgres"
  content user_sql_script
end

bash "create-postgres-user" do
  user "postgres"
  code "psql < /tmp/create-postgres-user.sql"
end

bash "populate-db-schema" do
  user node['darwin']['user']
  code "psql -d #{db_name} < #{node['darwin']['install_dir']}/txdav/common/datastore/sql_schema/current.sql"
end

package "memcached"

service "caldavd" do
  provider Chef::Provider::Service::Upstart
  action [:restart]
end
