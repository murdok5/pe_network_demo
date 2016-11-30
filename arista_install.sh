# login as 'admin' and enable API + install puppet-agent
enable
configure terminal
management api http-commands
no protocol https
protocol unix-socket
no shutdown
end
copy running-config startup-config
copy https://s3.amazonaws.com/puppet-agents/2016.4/puppet-agent-latest/repos/eos/4/PC1/i386/puppet-agent-1.7.1-1.eos4.i386.swix extension:
extension puppet-agent-1.7.1-1.eos4.i386.swix
# log in as root
/opt/puppetlabs/bin/puppet config --confdir /persist/sys/etc/puppetlabs/puppet set user root
/opt/puppetlabs/bin/puppet config --confdir /persist/sys/etc/puppetlabs/puppet set group root
puppet config set server "PUPPET-MASTER-FQDN
