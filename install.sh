#!/bin/sh

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun


# 下载安装包
wget https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/main/tailscale-openwrt.tgz

# 解压
tar x -pzvC / -f tailscale-openwrt.tgz

# 删除安装包
rm tailscale-openwrt.tgz
# 设定开机启动
/etc/init.d/tailscale enable
ls /etc/rc.d/*tailscale*
#启动
# /etc/init.d/tailscale start
/etc/rc.d/S99tailscale start
echo "Wait 30 seconds until the service starts"
sleep 30
/etc/init.d/tailscale status
echo "If the login fails, run 'tailscaled' command to check the log or re-run 'tailscale up'"
tailscale up
tailscale up
