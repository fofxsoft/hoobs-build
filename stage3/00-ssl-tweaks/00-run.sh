#!/bin/bash -e 

on_chroot << EOF
wget -O /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem

echo '' | tee -a /etc/profile
echo 'SSL_CERT_FILE=/etc/ssl/certs/cacert.pem' | tee -a /etc/profile
echo 'export SSL_CERT_FILE' | tee -a /etc/profile

truncate -s 0 /etc/sudoers

echo 'Defaults        env_reset' | tee -a /etc/sudoers
echo 'Defaults        mail_badpass' | tee -a /etc/sudoers
echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' | tee -a /etc/sudoers
echo 'Defaults        env_keep += "SSL_CERT_FILE"' | tee -a /etc/sudoers
echo '' | tee -a /etc/sudoers
echo 'root    ALL=(ALL:ALL) ALL' | tee -a /etc/sudoers
echo '%sudo   ALL=(ALL:ALL) NOPASSWD: ALL' | tee -a /etc/sudoers
EOF
