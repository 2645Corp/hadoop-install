#!/bin/bash

# Create user hadoop
# As root
useradd -m hadoop -s /bin/bash
passwd hadoop << EOF
${hadoop_password}
${hadoop_password}
EOF
adduser hadoop sudo

# Make tmp dir
rm -rf tmp
mkdir tmp
chown -R hadoop ./tmp

# Install openjdk and expect
apt-get update -y
# apt-get dist-upgrade -y 
# apt-get upgrade -y
apt-get install sudo openjdk-7-jre openjdk-7-jdk expect -y
str=$(dpkg -L openjdk-7-jdk | grep '/bin/javac')
JH=${str%%/bin/javac}
FILETMP=$(cat ~/.bashrc)
echo 'export JAVA_HOME='${JH} > /home/hadoop/.bashrc
echo 'export PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin' >> /home/hadoop/.bashrc
echo "$FILETMP" >> /home/hadoop/.bashrc
chown -R hadoop /home/hadoop/.bashrc
su hadoop -c "source /home/hadoop/.bashrc"
