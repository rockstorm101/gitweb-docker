#!/bin/sh

set -e

# Get OpenRC ready to run
# See: https://github.com/gliderlabs/docker-alpine/issues/437#issuecomment-667456518
mkdir -p /run/openrc
touch /run/openrc/softlevel
rc-status

# Allow Nginx to read/write the fcgiwrap socket
# (By default fcgiwrap's init script uses user 'fcgiwrap' and group
# 'www-data')
adduser nginx www-data

# Add '-f' option to fcgiwrap to redirect CGI's stderr over FastCGI
sed -i 's/args="-c/args="-f -c/' /etc/init.d/fcgiwrap

# Spawn FastCGI process
rc-service fcgiwrap start
