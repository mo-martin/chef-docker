#
# Cookbook Name:: myweb
# Recipe:: nginx
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nginx'
directory '/usr/share/nginx/html' do
  owner 'nginx'
  group 'nginx'
  mode '0755'
  action :create
  recursive true
end
