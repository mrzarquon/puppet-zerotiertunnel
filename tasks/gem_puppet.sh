#!/bin/bash

# Puppet Task Name: 

# configure vendor_modules here
vendored_modules=('puppetlabs-augeas_core' 'puppetlabs-host_core' 'puppetlabs-scheduled_task' 'puppetlabs-sshkeys_core' 'puppetlabs-zfs_core')

if [ ! -f '/usr/bin/ruby' ]; then
  apt-get install -y ruby
fi

if [ ! -f '/usr/local/bin/puppet' ]; then
  gem install puppet --no-ri --no-rdoc
fi

if [ ! -d '/opt/puppetlabs/puppet/vendor_modules' ]; then
  mkdir -p /opt/puppetlabs/puppet/vendor_modules
  for module in "${vendored_modules[@]}"; do
    echo "installing $module"
    /usr/local/bin/puppet module install $module --modulepath /opt/puppetlabs/puppet/vendor_modules
  done
fi

if [ ! -f '/opt/puppetlabs/puppet/VERSION' ]; then
  /usr/local/bin/puppet --version > /opt/puppetlabs/puppet/VERSION
fi

if [ ! -f '/opt/puppetlabs/puppet/bin/ruby' ]; then
  mkdir -p /opt/puppetlabs/puppet/bin/
  ln -s /usr/bin/ruby /opt/puppetlabs/puppet/bin/ruby
fi