#!/bin/sh

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun
rm -rf tailscale*
wget https://cdn.jsdelivr.net/gh/cyz0105/tailscale-openwrt@main/tailscale-openwrt.tgz
tar x -zvC / -f tailscale-openwrt.tgz
/etc/init.d/tailscale enable
ls /etc/rc.d/S*tailscale*
/etc/init.d/tailscale start
tailscale up
