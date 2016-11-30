# scrip to install Cisto NXOS agent and connect to master qdn passed as param
# param 1 - FQDN to master
master=$1

#commands to run in order:
run bash
sudo ip netns exec management bash
yum install http://yum.puppetlabs.com/puppetlabs-release-pc1-cisco-wrlinux-5.noarch.rpm -y
yum install puppet-agent -y
export PATH=$PATH:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/puppet/lib
cat > /etc/puppetlabs/puppet/puppet.conf << EOF
server = ${master}
EOF
puppet agent -t
