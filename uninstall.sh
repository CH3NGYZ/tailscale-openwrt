#!/bin/sh

/etc/init.d/tailscale disable
/tmp/tailscale down --accept-risk=lose-ssh
rm -rf /etc/init.d/tailscale*
rm -rf /usr/bin/tailscale*
rm -rf /tmp/tailscale*
rm -rf /var/lib/tailscale*
# cd /
# find . -type f -name "*tailscale*" -exec rm -f {} +
# find . -type d -name "*tailscale*" -exec rm -rf {} +
echo "已清除"
