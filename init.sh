# This scrip creates 3 vmpooler machines and outputs their names.  
# machine1 - centos7, PE Master
# machine2 - cisco device
# machine3 - arista device

# prereq - https://confluence.puppetlabs.com/pages/viewpage.action?pageId=28610683


master=$(floaty get centos-7-x86_64)
#cisco=$(floaty get cisco-nxos-9k-x86_64)
#arista=$(floaty get arista-4-i386)

echo "The Master is: $master"
