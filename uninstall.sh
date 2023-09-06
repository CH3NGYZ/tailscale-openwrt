#!/bin/sh

/tmp/tailscale down --accept-risk=lose-ssh
/tmp/tailscale logout
/etc/init.d/tailscale disable
/etc/init.d/tailscale stop
ip link delete tailscale0
rm -rf /etc/tailscale*
rm -rf /etc/config/tailscale*
rm -rf /etc/init.d/tailscale*
rm -rf /usr/bin/tailscale*
rm -rf /tmp/tailscale*
rm -rf /var/lib/tailscale*
cd /
find . -type f -name "*tailscale*" -exec rm -f {} +
find . -type d -name "*tailscale*" -exec rm -rf {} +
echo "The remaining files have been cleared, it is highly recommended to restart your openwrt"
