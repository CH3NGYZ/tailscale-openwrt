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
echo "The architecture of the current machine is ${arch_}${endianness} , the schema code built into the script may not match your machine, please leave a comment on this issue so that the author can modify the script in time: https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
exit 1
fi

if [ -e /tmp/tailscaled ]; then
        echo "Residue exists, uninstall it, restart your machine and try again"
        exit 1
fi

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun
echo "If the package fails to be installed, manually run the following command to install the package. If the problem persists, manually locate the cause:"
echo "opkg install libustream-openssl"
echo "opkg install ca-bundle"
echo "opkg install kmod-tun"
echo "All three packages are indispensable"

# 下载安装包
wget --tries=5 -c -t 60 https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/main/tailscale-openwrt.tgz

# 解压
tar x -pzvC / -f tailscale-openwrt.tgz

# 删除安装包
rm tailscale-openwrt.tgz
# 设定开机启动
/etc/init.d/tailscale enable
ls /etc/rc.d/*tailscale*
#启动
# /etc/init.d/tailscale start
/etc/rc.d/S90tailscale start
echo "Please wait, the timeout time is three minutes, the Tailscaled service is downloading the Tailscale executable file in the background..."

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
            echo "The script has timed out. Please manually open the Syslog to see the reason for the failure."
            exit 1
        else
            sleep 2
        fi
    fi
done

echo "If the login fails, check the background service running status by running /etc/init.d/tailscaled status"
tailscale up
tailscale up
echo "The current machine architecture is arch_:${arch_}${endianness} | arch:${arch} . If it works successfully, leave a comment on this issue so that the author can revise the documentation in time: https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
