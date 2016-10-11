FROM centos:7

RUN yum -y install https://packages.chef.io/stable/el/7/chef-12.13.37-1.el7.x86_64.rpm

# Add the Chef cookbooks and runtime info to a volume container
COPY zero.rb first-boot.json /tmp/chef/
RUN ls -la /tmp/chef
COPY site-cookbooks/ /tmp/chef/cookbooks/
RUN ls -la /tmp/chef/cookbooks

# Create temporary volumes, to which Chef is installed
VOLUME /tmp/chef
VOLUME /opt
