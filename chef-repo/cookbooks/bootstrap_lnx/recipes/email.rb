#
# Cookbook:: bootstrap_lnx
# Recipe:: email
#
# Copyright:: 2020, The Authors, All Rights Reserved.
%w{ cyrus-sasl-plain mailx }.each do |pkgs|
 yum_package "#{pkgs}" do
  action [:install]
 end
end

cookbook_file '/etc/postfix/main.cf' do
 source 'email/main.cf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :reload, "service[postfix]"
end

cookbook_file '/etc/postfix/sasl_passwd' do
 source 'email/sasl_passwd'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[postmap-sasl]', :immediately
end

execute "postmap-sasl" do
 cwd '/etc/postfix/'
 command "postmap sasl_passwd"
 action :run
end

service "postfix" do
 supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
 action [:enable, :start]
end
