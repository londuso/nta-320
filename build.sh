!#/bin/bash
#this should be the finishing script for a micro with a 50G hard drive

yum -y install rpm-build make gcc git                                       # install rpm tools,compiling tools and source tools
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}                    # create the rpmbuild directory structure
# (the docs say this happens by default,this is incorrect on centos 7)
cd ~/
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros                       # set the rpmbuild path in an .rpmmacros file
cd ~/rpmbuild/SOURCES
git clone https:// github.com/NagiosEnterprises/nrpe.git                    # get the nrpe source from github
git clone https:// github.com/NagiosEnterprises/nagioscore.got              # get the nagios source fro github

tar -czv nrpe-3.1.tar.gz /root/rpmbuild/SOURCES/nrpe                        #Tar up the source (needed to create an RPM)
tar -czv nagioscore-4.3.1.tar.gz root/rpmbuild/SOURCES/nagioscore           # Tar up the source (needed to create an RPM)

mv nagioscore nagioscore-4.3.1                                              # clean up our source dir by making a directory
mv nrpe nrpe-3.1                                                            # Structure that will enable us have multiple
mkdir nagiscore                                                             # versions of our source code
mkdir nrpe
mv nagioscore-4.3.1 nagioscore
mv nrpe-3.1 nrpe

cd ../SPECS                                                                   # head to the SPECS directory  
cp /usr/share/vim/vimfiles/template.spec .                                   # copy a template .spec file over from /usr/share
