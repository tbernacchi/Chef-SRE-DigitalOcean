#
# Author:: Marius Ducea (marius@promethost.com)
# Cookbook:: nodejs
# Recipe:: npm
#
# Copyright:: 2010-2017, Promet Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
case node['nodejs']['npm']['install_method']
when 'embedded'
  include_recipe 'nodejs::install'
when 'source'
  include_recipe 'nodejs::npm_from_source'
else
  Chef::Log.error('No install method found for npm')
end

%w{ /usr/local/lib/nodejs /root/CASE_LNX/app/ }.each do |dirs|
 directory "#{dirs}" do
  recursive true
  owner 'root'
  group 'root'
  mode 0644
  action :create
 end
end

cookbook_file '/root/CASE_LNX/app/package.json' do
  source 'package.json'
  action :create
end

npm_package 'app-hello' do
  path '/root/CASE_LNX/app' # The root path to your project, containing a package.json file
  json true
  user 'root'
  options ['--production'] # Only install dependencies. Skip devDependencies
end 
