#
# Cookbook:: bootstrap_lnx
# Recipe:: node_js
#
# Copyright:: 2020, The Authors, All Rights Reserved.
cookbook_file "/usr/lib/systemd/system/hello.service" do
 source "systemd/hello.service"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[daemon-reload]', :immediately
end

execute 'daemon-reload' do
 command 'systemctl daemon-reload'
 action :nothing
end

cookbook_file '/root/CASE_LNX/app/app.js' do
 source 'app/app.js'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :restart, 'service[hello]', :immediately
end

service "hello" do
 supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
 action [:enable, :start]
end 
