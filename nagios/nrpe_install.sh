#!/bin/bash
for file in $( ls /etc/yum.repos.d/ ); do mv /etc/yum.repos.d/$file /etc/yum.repos.d/$file.bak; done
echo "[nti-310-epel]
name=NTI310 EPEL
baseurl=http://104.197.59.12/epel
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-310-base]
name=NTI310 BASE
baseurl=http://104.197.59.12/base
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-310-extras]
name=NTI310 EXTRAS
baseurl=http://104.197.59.12/extras/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
echo "[nti-310-updates]
name=NTI310 UPDATES
baseurl=http://104.197.59.12/updates/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/local-repo.repo
chmod 775 /etc/nagios/servers # added this from slack
usermod -a -G root londuso35 (where nicolebade is your username) #added from slack.
yum install -y nagios-plugins nrpe nagios-plugins-load nagios-plugins-ping nagios-plugins-disk nagios-plugins-httpd nagios-plugins-procs wget 
# BUG:https://osric.com/chris/accidental-developer/2016/12/missing-nagios-plugins-in-centos-7/ (nrpe plugins have been packaged seperately and don't install with nagios-
plugins-all)
# BUG #2 https://cloudwafer.com/blog/installing-nagios-agent-npre-on-centos/ (the nrpe config is commented out and checks are not defined)
# use sed statements to uncomment NRPE config and add the appropriate flags
#add in command [check_mem]=/usr/lib64/nagios/plugins/check_mem.sh
# install custom mem monitor
wget-o /usr/lib64/nagios/plugins/check_mem.sh https://raw.githubusercontent.com/nic-instruction/hello-nti-320/master/check_mem.sh
chmod +x /usr/lib64/nagios/plugins/check_mem.sh
systemctl enable nrpe
systemctl start nrpe
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1,10.128.0.0/g' /etc/nagios/nrpe.cfg
sed -i "s,command[check_hda1]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /dev/hda1,command[check_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p
echo "command [check_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /dev/disk" >> /etc/nagios/nrpe.cfg
echo "command [check_disk]=/usr/lib64/nagios/plugins/check_mem -w 80% -c 90%" >> /etc/nagios/nrpe.cfg

systemctl restart nrpe
#troubleshooting
#from nagios server: /usr/lib64/nagios/plugins/check_nrpe -H 10.0.0.3 -c check_load from NRPE server execute the command in libexec /usr/lib64/nagios/plugins/
chmod 775 /etc/nagios/servers

