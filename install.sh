#!/bin/sh

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun

# 删除残留
rm -rf *tailscale*
rm -rf /tmp/*tailscale*

# 下载安装包
wget https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/tailscale-openwrt.tgz

# 解压
tar x -zvC / -f tailscale-openwrt.tgz
# 删除安装包
rm tailscale-openwrt.tgz

# 设定开机启动
/etc/init.d/tailscale enable

ls /etc/rc.d/S*tailscale*

#启动
/etc/init.d/tailscale start
tailscale up
