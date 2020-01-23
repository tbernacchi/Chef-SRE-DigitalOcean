#
# Cookbook:: bootstrap_lnx
# Recipe:: scripts
#
# Copyright:: 2020, The Authors, All Rights Reserved.
cookbook_file '/usr/local/bin/monitoring_restart.sh' do
 source 'scripts/monitoring_restart.sh'
 owner 'root'
 group 'root'
 mode '0755'
 action :create
end

cookbook_file '/etc/cron.d/monit-restart' do
 source 'cron.d/monit-restart'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/usr/local/bin/nginx_access_report.sh' do
 source 'scripts/nginx_access_report.sh'
 owner 'root'
 group 'root'
 mode '0755'
 action :create
end

cookbook_file '/etc/cron.d/nginx-report' do
 source 'cron.d/nginx-report'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
