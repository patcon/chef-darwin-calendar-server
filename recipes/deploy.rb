#
# Cookbook Name:: darwin-calendar-server
# Recipe:: deploy
#
# Copyright 2013, rhodey orbits

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user  deploy[:user]
    group deploy[:group]
    path  deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app         application
  end
  
  bash "move_darwin" do
    user "root"
    cwd  deploy[:deploy_to]
    code <<-EOH
    cp -R ./current/* #{node['darwin']['install_dir']}
    chown #{node['darwin']['user']} -R #{node['darwin']['install_dir']}
    EOH
  end
  
  include_recipe 'darwin-calendar-server::patch'
  include_recipe 'darwin-calendar-server::configure'
  include_recipe 'darwin-calendar-server::install'
  
  service "caldavd" do
    provider Chef::Provider::Service::Upstart
    action [:restart]
  end

end