#!/bin/sh

# Start sshd
/usr/sbin/sshd &

# Start ngrok
ngrok start --all -config /app/ngrok.yml
