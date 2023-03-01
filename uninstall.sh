#!/bin/sh

/etc/init.d/tailscale disable
rm -rf /etc/init.d/tailscale*
rm -rf /usr/bin/tailscale*
rm -rf /tmp/tailscale*
rm -rf /var/lib/tailscale*
echo "已清除部分文件,但接口还在,需要手动删除"
