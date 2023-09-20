#!/bin/sh

cleanup() {
    echo "The configuration file has been cleared and is looking for residual files. This step will take a long time. Please wait patiently."
    cd /
    find . -type f -name "*tailscale*" -exec rm -f {} +
    find . -type d -name "*tailscale*" -exec rm -rf {} +
    echo "Cleared, it is highly recommended to restart your OpenWRT"
}

if [ -e /tmp/tailscaled ]; then
    echo "File exists, stop the Tailscale service and cleanup"
    /etc/init.d/tailscale stop
    /tmp/tailscale down --accept-risk=lose-ssh
    /tmp/tailscale logout
    /etc/init.d/tailscale disable
    rm -rf /etc/tailscale*
    rm -rf /etc/config/tailscale*
    rm -rf /etc/init.d/tailscale*
    rm -rf /usr/bin/tailscale*
    rm -rf /tmp/tailscale*
    rm -rf /var/lib/tailscale*
    ip link delete tailscale0
    cleanup
else
    echo "The file does not exist, cleanup directly"
    rm -rf /etc/tailscale*
    rm -rf /etc/config/tailscale*
    rm -rf /etc/init.d/tailscale*
    rm -rf /usr/bin/tailscale*
    rm -rf /tmp/tailscale*
    rm -rf /var/lib/tailscale*
    ip link delete tailscale0
    cleanup
fi
