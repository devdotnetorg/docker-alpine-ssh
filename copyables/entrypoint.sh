#!/bin/bash
set -e

echo "Start entrypoint.sh"

# Environment variables that are used if not empty:
#   PSWD

#Folder for sshd. No Change.
mkdir -p /var/run/sshd

# Config SSH
sed -ri "s|^#PermitRootLogin|PermitRootLogin|" /etc/ssh/sshd_config
sed -i "s|PermitRootLogin without-password|PermitRootLogin yes|" /etc/ssh/sshd_config 
sed -i "s|PermitRootLogin prohibit-password|PermitRootLogin yes|" /etc/ssh/sshd_config 
sed -ri "s|^#?PermitRootLogin\s+.*|PermitRootLogin yes|" /etc/ssh/sshd_config
#
sed -ri "s|^#PasswordAuthentication|PasswordAuthentication|" /etc/ssh/sshd_config
sed -ri "s|^PasswordAuthentication no|PasswordAuthentication yes|" /etc/ssh/sshd_config
#
sed -ri "s|UsePAM yes|#UsePAM yes|g" /etc/ssh/sshd_config
#

#Set password
echo "Set  password of user for sshd"
echo 'root:'${PSWD} |chpasswd

echo "Run sshd"

exec "$@"