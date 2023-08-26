#!/bin/sh

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun


# 下载安装包
wget https://ghproxy.com/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz

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
echo "请等待30秒直到服务启动"
sleep 30
/etc/init.d/tailscale status
echo "如果无法登陆, 请运行 tailscaled 命令检查日志"
tailscale up
