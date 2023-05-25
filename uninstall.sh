#!/bin/sh

/etc/init.d/tailscale disable
/tmp/tailscale down --accept-risk=lose-ssh
rm -rf /etc/init.d/tailscale*
rm -rf /usr/bin/tailscale*
rm -rf /tmp/tailscale*
rm -rf /var/lib/tailscale*
echo "已清除"
