#
# Cookbook:: bootstrap_lnx
# Recipe:: chef-client
#
# Copyright:: 2020, The Authors, All Rights Reserved.
cookbook_file '/etc/sysconfig/chef-client' do
 source 'sysconfig/chef-client'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/usr/lib/systemd/system/chef-client.service' do
 source 'chef-client/chef-client.service'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[daemon-reload]', :immediately
end

execute "daemon-reload" do
 user "root"
 command "systemctl daemon-reload"
 action :nothing
end

systemd_unit 'chef-client.service' do
 action [ :enable, :start ] 
end 
