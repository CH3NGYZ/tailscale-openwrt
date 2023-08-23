#!/bin/sh

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun


# 下载安装包
wget https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/tailscale-openwrt.tgz

# 解压
tar x -pzvC / -f tailscale-openwrt.tgz

# 删除安装包
rm tailscale-openwrt.tgz

# 设定开机启动
/etc/init.d/tailscale enable

ls /etc/rc.d/S*tailscale*

#启动
/etc/init.d/tailscale start
tailscale up
