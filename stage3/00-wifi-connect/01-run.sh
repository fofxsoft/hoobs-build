#!/bin/bash -e 

install -m 644 files/issue "${ROOTFS_DIR}/etc/issue"
install -m 644 files/motd "${ROOTFS_DIR}/etc/update-motd.d/20-hoobs"
install -m 644 files/wifi-connect.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/wifi-connect-startup "${ROOTFS_DIR}/usr/local/sbin/"
install -m 644 files/raspbian-install.sh "${ROOTFS_DIR}/"
install -m 644 files/wifi-connect-hoobs.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
set -x 

chmod u+x /raspbian-install.sh
sudo /raspbian-install.sh -y
rm -rf /raspbian-install.sh

chmod +x /usr/local/sbin/wifi-connect-startup
chmod +x /etc/update-motd.d/20-hoobs

systemctl daemon-reload
systemctl enable wifi-connect
systemctl enable NetworkManager
systemctl disable dhcpcd

wget -O /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem

echo '' | tee -a /etc/profile
echo 'SSL_CERT_FILE=/etc/ssl/certs/cacert.pem' | tee -a /etc/profile
echo 'export SSL_CERT_FILE' | tee -a /etc/profile
EOF
