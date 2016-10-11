#
# Cookbook Name:: myweb
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yum -y install http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-0.1.noarch.rpm" do
  not_if 'ls /etc/yum.repos.d/rpmfusion*'
end
# Curl required for testing
package 'curl'
