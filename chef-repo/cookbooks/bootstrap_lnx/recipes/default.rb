#
# Cookbook:: bootstrap_lnx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
include_recipe 'bootstrap_lnx::app-hello'
include_recipe 'bootstrap_lnx::nginx'
include_recipe 'bootstrap_lnx::email'
include_recipe 'bootstrap_lnx::scripts'
include_recipe 'bootstrap_lnx::chef-client'
