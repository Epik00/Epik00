#!/bin/bash
echo
echo "Ctrl-Shift-V"
echo 310304 | xclip -sel c
su netadmin -c "sudo -S rm /var/log/auth.log* /var/log/remoteInstaller.log /var/log/apt/*.log* /var/log/syslog*"
rm ~/.bash_history ~/.wget-hsts
sleep 5
clear