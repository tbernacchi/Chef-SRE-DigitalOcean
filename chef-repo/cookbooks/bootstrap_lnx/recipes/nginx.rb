#
# Cookbook:: bootstrap_lnx
# Recipe:: nginx
#
# Copyright:: 2020, The Authors, All Rights Reserved.
cookbook_file '/etc/sysconfig/selinux' do
 source 'sysconfig/selinux'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if 'getenforce | grep -q Disabled'
end

execute "yum-clean-all" do
 command "yum clean all"
 action :run
end

yum_package 'epel-release' do 
 action :install
 not_if { File.exist? ("/etc/yum.repos.d/epel.repo") }
end 

yum_package 'nginx' do
 package_name 'nginx'
 action	[ :install]
end

template "/etc/nginx/nginx.conf" do
 source "nginx.conf.erb"
 owner "root"
 group "root"
 mode 0644
 notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
 supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
 action [:enable, :start]
end
