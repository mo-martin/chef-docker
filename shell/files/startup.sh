#!/bin/bash

# Check if chef-client is still available, if it is we must be installing
if [[ -e /opt/chef/bin/chef-client ]]
then
     /opt/chef/bin/chef-client -c /tmp/chef/zero.rb -z -j /tmp/chef/first-boot.json
     nginx
else
   # If we are here then the install has already happened
     nginx && while true; do sleep 1000; done
fi
