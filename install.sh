#!/bin/sh
arch_=`uname -m`
if [ "$arch_" == "i386" ]; then
arch=386
elif [ "$arch_" == "x86_64" ]; then
arch=amd64
elif [ "$arch_" == "armv7l" ]; then
arch=arm
elif [ "$arch_" == "aarch64" ]; then
arch=arm64
elif [ "$arch_" == "armv8l" ]; then
arch=arm64
elif [ "$arch_" == "geode" ]; then
arch=geode
elif [ "$arch_" == "mips" ]; then
endianness=`echo -n I | hexdump -o | awk '{ print (substr($2,6,1)=="1") ? "le" : ""; exit }'`
elif [ "$arch_" == "riscv64" ]; then
arch=riscv64
else
echo "The current architecture of the machine is ${arch_}${endianness}, and scripts are not compatible with that architecture, so please leave a comment on this issue so that the author can modify the script in time: https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
exit 1
fi
echo "The current architecture of the machine is ${arch_}${endianness}|${arch}, which scripts are compatible with, so leave a comment on this issue so that the author can modify the architecture parts of the documentation: https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"

if [ -e /tmp/tailscaled ]; then
        echo "Residual files exist. Uninstall them, restart your machine, and try again"
        exit 1
fi
echo "wait for 5 seconds"
sleep 5
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
