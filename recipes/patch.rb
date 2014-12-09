#
# Cookbook Name:: darwin-calendar-server
# Recipe:: patch
#
# Copyright 2013, rhodey orbits

cookbook_file "#{Chef::Config['file_cache_path']}/darwin-patch-r11995.diff" do
  source "darwin-patch-r11995.diff"
end

bash "patch-darwin-calendar" do
  user node['darwin']['user']
  cwd node['darwin']['install_dir']
  code "patch --strip=0 --input=#{Chef::Config['file_cache_path']}/darwin-patch-r11995.diff"
end
