#!/bin/bash

mkdir -p /var/run/sshd
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

echo "$SSH_KEY" >> /root/.ssh/authorized_keys