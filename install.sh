#!/bin/sh
if [ -e /tmp/tailscaled ]; then
        echo "存在残留, 请卸载并重启后重试"
        exit 1
fi
# opkg update
opkg install libustream-openssl ca-bundle kmod-tun


# 下载安装包
wget --tries=5 -c -t 60 https://ghproxy.com/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz

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
echo "Please wait, Tailscaled service is downloading the Tailscale executable file in the background......"

start_time=$(date +%s)
timeout=180  # 3分钟的超时时间

while true; do
    if [ -e /tmp/tailscaled ]; then
        echo "/tmp/tailscaled is already exists. Go on"
        break
    else
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))
        if [ $elapsed_time -ge $timeout ]; then
            echo "The download timed out. You need to manually open the system log to view the failure cause..."
            exit 1
        else
            sleep 2
        fi
    fi
done

echo "If you cannot log in, run the '/etc/init.d/tailscale stop && clear && /usr/bin/tailscaled 'command to check the log, or re-run 'tailscale up'..."
tailscale up
tailscale up
