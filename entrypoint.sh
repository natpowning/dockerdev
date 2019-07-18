#!/bin/bash

PASS=$(openssl rand -base64 8)

echo "root:${PASS}" | chpasswd

echo "=============================================================="
echo
echo "root password: ${PASS}"
echo
echo "=============================================================="

/usr/sbin/sshd -D

