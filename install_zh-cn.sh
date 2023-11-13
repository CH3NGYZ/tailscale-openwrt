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
echo "当前机器的架构是 ${arch_}${endianness} , 脚本内置的架构代码可能不符合您的机器, 请在这个issue留下评论以便作者及时修改脚本: https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
exit 1
fi

if [ -e /tmp/tailscaled ]; then
        echo "存在残留, 请卸载并重启后重试"
        exit 1
fi

# opkg update
opkg install libustream-openssl ca-bundle kmod-tun
echo "如果包安装失败,请手动运行以下命令安装,如果还是不行,请手动查找原因:"
echo "opkg install libustream-openssl"
echo "opkg install ca-bundle"
echo "opkg install kmod-tun"
echo "以上三个包缺一不可"

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
echo "请等待,超时时间为三分钟, Tailscaled 服务正在后台下载 Tailscale 可执行文件..."

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
            echo "超时，退出脚本,请手动打开luci界面-系统日志查看失败原因,也可运行 tailscale 查看下载情况"
            exit 1
        else
            sleep 2
        fi
    fi
done

echo "如果无法登陆, 请检查后台服务运行状态 /etc/init.d/tailscaled status"
tailscale up
tailscale up
echo "当前机器的架构是 arch_:${arch_}${endianness} | arch:${arch}，如果成功运行，请在这个issue留下评论以便作者及时修改说明文档：https://github.com/CH3NGYZ/tailscale-openwrt/issues/6。如架构已验证,您可不必再留言。"
