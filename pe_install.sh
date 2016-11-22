 #!/bin/bash
set -ex
host_name=$(hostname -f)
pe_url="http://pe-releases.puppetlabs.net/2016.4.0/puppet-enterprise-2016.4.0-el-7-x86_64.tar.gz"
yum install vim -y
systemctl disable firewalld
systemctl stop firewalld
echo 127.0.0.1 $(hostname -f) >> /etc/hosts
mkdir -p /etc/puppetlabs/puppet
echo '*' > /etc/puppetlabs/puppet/autosign.conf
curl -o pe.archive $pe_url
tar -xf pe.archive
cat > pe.conf <<EOL
{
  "console_admin_password": "puppetlabs"
  "puppet_enterprise::puppet_master_host": "${host_name}"
  "puppet_enterprise::profile::master::check_for_updates": false
}
EOL 
./puppet-enterprise-*-el-7-x86_64/puppet-enterprise-installer -c pe.conf
