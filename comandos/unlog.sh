#!/bin/bash
echo
echo Eliminador de Logs
echo
echo "Ctrl-Shift-V"
echo th03013728 | xclip -sel c
su netadmin -c "sudo -S rm /var/log/auth.log* /var/log/remoteInstaller.log /var/log/apt/*.log* /var/log/syslog*" 2>/dev/null
rm ~/.bash_history ~/.wget-hsts
sleep 10
clear