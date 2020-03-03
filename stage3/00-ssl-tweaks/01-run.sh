#!/bin/bash -e 

on_chroot << EOF
wget -O /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem

echo 'SSL_CERT_FILE=/etc/ssl/certs/cacert.pem' | tee -a /etc/profile
echo 'export SSL_CERT_FILE' | tee -a /etc/profile
echo 'Defaults env_keep += "SSL_CERT_FILE"' | tee -a /etc/sudoers
EOF
