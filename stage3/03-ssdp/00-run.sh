#!/bin/bash -e

install -m 644 files/ssdpd.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/ssdp-responder-v1.6.1-linux-arm.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
tar -xzf /ssdp-responder-v1.6.1-linux-arm.tar.gz -C / --no-same-owner
rm -rf /ssdp-responder-v1.6.1-linux-arm.tar.gz

systemctl daemon-reload
systemctl enable ssdpd
EOF
