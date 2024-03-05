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
    echo "INSTALL: --------------------------------------------"
    echo "当前机器的架构是 ${arch_}${endianness}"
    echo "脚本内置的架构代码可能有误,不符合您的机器"
    echo "请在这个issue留下评论以便作者及时修改脚本"
    echo "https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
    echo "------------------------------------------------------"
exit 1
fi
if [ -e /tmp/tailscaled ]; then
        echo "INSTALL: ------------------"
        echo "存在残留, 请卸载并重启后重试"
        echo "卸载命令: wget -qO- https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/uninstall.sh | sh"
        echo "---------------------------"
        exit 1
fi
opkg update
opkg install libustream-openssl ca-bundle kmod-tun coreutils-timeout
echo "INSTALL: ------------------------------------------------"
echo "如果包安装失败,请手动运行以下命令安装,如果还是不行,请手动查找原因:"
echo "opkg install libustream-openssl"
echo "opkg install ca-bundle"
echo "opkg install kmod-tun"
echo "opkg install coreutils-timeout"
echo "以上四个包缺一不可"
echo "---------------------------------------------------------"

# 下载安装包
timeout_seconds=5

download_success=false

# 代理列表
proxy_zip_urls="https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://fastly.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://gcore.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://jsdelivr.b-cdn.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://mirror.ghproxy.com/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://raw.fgit.cf/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz"

for proxy_zip_url in $proxy_zip_urls; do
    # 使用 timeout 命令设定超时时间
    if timeout $timeout_seconds wget -q $proxy_zip_url -O - | tar x -zvC / -f - > /dev/null 2>&1; then
        download_success=true
        echo "INSTALL: ------"
        echo "下载安装脚本成功!"
        echo "---------------"
        break
    else
        echo "INSTALL: ------------------"
        echo "下载安装脚本失败，尝试下一个代理"
        echo "---------------------------"
    fi
done

if [ "$download_success" != true ]; then
    echo "INSTALL: -------------------------"
    echo "所有代理下载均失败，请检查网络或稍后再试"
    echo "----------------------------------"
    exit 1
fi

/etc/init.d/tailscale enable

echo "INSTALL: --------------"
echo "正在启动 Tailscale 下载器"
echo "-----------------------"
tailscale_downloader
echo "INSTALL: ----------------"
echo "正在启动 Tailscale 后台服务"
echo "-------------------------"
/etc/init.d/tailscale start
sleep 3

echo "INSTALL: ----------------"
echo "正在启动 Tailscale 前台程序"
echo "-------------------------"
tailscale up

echo "INSTALL: ---------------------------------------------"
echo "当前机器的架构是 arch_:${arch_}${endianness}| arch:${arch}"
echo "如果成功运行, 请在这个issue留下评论以便作者及时修改说明文档: "
echo "https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
echo "------------------------------------------------------"
