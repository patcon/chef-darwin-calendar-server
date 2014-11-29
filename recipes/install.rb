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