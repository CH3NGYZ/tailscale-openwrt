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
echo "请等待, Tailscaled 服务正在后台下载 Tailscale 可执行文件..."

start_time=$(date +%s)
timeout=180  # 3分钟的超时时间

while true; do
    if [ -e /tmp/tailscaled ]; then
        echo "/tmp/tailscaled 存在, 继续"
        break
    else
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))
        if [ $elapsed_time -ge $timeout ]; then
            echo "超时，退出脚本,请手动打开系统日志查看失败原因"
            exit 1
        else
            sleep 2
        fi
    fi
done

echo "如果无法登陆, 请运行 '/etc/init.d/tailscale stop && clear && /usr/bin/tailscaled' 命令检查日志, 或重新运行 tailscale up"
tailscale up
tailscale up
