# 在openwrt上最简单的tailscale部署方法

## 仅兼容 aarch64、x86_64、mips、armv7l

[![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV "")

### 0x00 安装

```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

### 0x01 卸载

```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
```

### 0x02 更新

```
reboot
```

### 0x03 troubleshoot

- ghproxy.net无法链接，或链接极慢
    1. 先在其他设备上`ping ghproxy.net`,确保不是因为ghproxy.net的原因
    2. 如果`安装`时无法下载，可能是*openclash*等翻墙工具影响了*ghproxy*，请考虑停止翻墙工具，再安装
    3. 如果`开机`时无法下载，可能是*openclash*等翻墙工具影响了*ghproxy*，请考虑修改启动脚本`/usr/bin/tailscale`和`/usr/bin/tailscaled`。
    
    以openclash为例，在脚本第二行添加禁用翻墙工具的命令：
    ```
    echo "============stop openclash============"
    uci set openclash.config.enable='0'
    uci commit openclash
    /etc/init.d/openclash start
    echo "============openclash stoped============"
    ```
    
    将最后一行 `/tmp/tailscale "$@"` 替换为以下命令：
    ```
    /tmp/tailscale "$@" &
    echo "============start openclash============"
    sleep 10
    uci set openclash.config.enable='1'
    uci commit openclash
    /etc/init.d/openclash start
    echo "============openclash started============"
    ```
    
    其他工具请自行搜索uci命令。
