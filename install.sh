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
opkg install libustream-openssl ca-bundle kmod-tun coreutils-timeout
echo "---------------------------------------------------------"
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
proxy_zip_urls="https://mirror.ghproxy.com/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://github.moeyy.xyz/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://gh-proxy.com/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://fastly.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://raw.fgit.mxtrans.net/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz
https://gcore.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://jsdelivr.b-cdn.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/tailscale-openwrt.tgz
https://raw.fgit.cf/CH3NGYZ/tailscale-openwrt/chinese_mainland/tailscale-openwrt.tgz"

for proxy_zip_url in $proxy_zip_urls; do
    echo "尝试下载 $proxy_zip_url..."
    # 使用 timeout 命令设定超时时间
    if timeout $timeout_seconds wget -q $proxy_zip_url -O - | tar x -zvC / -f - > /dev/null 2>&1; then
        download_success=true
        echo "----------------------------------"
        echo "下载安装脚本 tailscale-openwrt.tgz 成功!"
        echo "----------------------------------"
        break
    else
        echo "下载失败，尝试下一个代理..."
    fi
done

if [ "$download_success" != true ]; then
    echo "----------------------------------"
    echo "所有代理下载均失败，请检查网络或稍后再试。"
    echo "----------------------------------"
    exit 1
fi

# 设定开机启动
/etc/init.d/tailscale enable
# ls /etc/rc.d/*tailscale*
#启动
# /etc/init.d/tailscale start

echo "-----------------------------"
echo "... 正在下载 Tailscale 文件 ..."
echo "-----------------------------"
tailscale_downloader
echo "-----------------------------"
echo "... 正在启动 Tailscale 服务 ..."
echo "-----------------------------"
/etc/init.d/tailscale start
sleep 3

echo "-----------------------------"
echo "... 正在准备 Tailscale 登录 ..."
echo "-----------------------------"
tailscale up
# start_time=$(date +%s)
# timeout=180  # 3分钟的超时时间

# while true; do
#     if [ -e /tmp/tailscaled ]; then
#         echo "/tmp/tailscaled 存在, 继续"
#         break
#     else
#         current_time=$(date +%s)
#         elapsed_time=$((current_time - start_time))
#         if [ $elapsed_time -ge $timeout ]; then
#             echo "超时，退出脚本,请手动打开luci界面-系统日志查看失败原因,也可运行 tailscale 查看下载情况"
#             exit 1
#         else
#             sleep 2
#         fi
#     fi
# done

# echo "如果无法登陆, 请运行 '/etc/init.d/tailscale stop && clear && /usr/bin/tailscaled' 命令检查日志, 或重新运行 tailscale up"
# tailscale up
# tailscale up

echo "--------------------------------------------------------------"
echo "当前机器的架构是 arch_:${arch_}${endianness}| arch:${arch}
echo "如果成功运行, 请在这个issue留下评论以便作者及时修改说明文档: "
echo "https://github.com/CH3NGYZ/tailscale-openwrt/issues/6"
echo "--------------------------------------------------------------"