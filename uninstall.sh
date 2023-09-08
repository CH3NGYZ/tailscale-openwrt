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
echo "已清除配置文件, 正在查找残余文件, 此步需要的时间较久,请耐心等待"
cd /
find . -type f -name "*tailscale*" -exec rm -f {} +
find . -type d -name "*tailscale*" -exec rm -rf {} +
echo "已清除, 强烈推荐重启您的openwrt"
