 #!/bin/bash
set -ex
hostname=$(hostname -f)
pe_url=$(http://pe-releases.puppetlabs.net/2016.4.0/puppet-enterprise-2016.4.0-el-7-x86_64.tar.gz)
yum install vim -y
systemctl disable firewalld
systemctl stop firewalld
echo 127.0.0.1 $(hostname) >> /etc/hosts
mkdir -p /etc/puppetlabs/puppet
echo '*' > /etc/puppetlabs/puppet/autosign.conf
retrycurl() { set +e; while :; do curl "$@"; [ "$?" = 0 ] && break; done; set -e; }
retrycurl --max-time 30 -o pe.archive $pe_url
tar -xf pe.archive
cat > pe.conf <<-EOF
{
  "console_admin_password": "puppetlabs"
  "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
  "puppet_enterprise::use_application_services": true
  "puppet_enterprise::profile::master::check_for_updates": false
}
EOF 
./puppet-enterprise-*-el-7-x86_64/puppet-enterprise-installer -c pe.conf
