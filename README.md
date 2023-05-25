# 在 openwrt 上最简单的 tailscale 部署方法

## 仅兼容 aarch64、x86_64、mips、armv7l

[![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

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

- ghproxy.net 无法链接，或链接极慢

  - 先在其他设备上`curl ghproxy.net`,如果有显示 html 基本结构，则`ghproxy.net`链接正常。
  - 如果`ghproxy.net`链接正常，则可能是*openclash*等翻墙工具影响了*ghproxy*。 
    - 如果`安装`时无法下载，请考虑停止翻墙工具，再安装。
    - 如果`开机`时无法下载，请考虑修改启动脚本`/usr/bin/tailscale`和`/usr/bin/tailscaled` 
      - 以 openclash 为例，在脚本第二行添加禁用翻墙工具的命令：
        - ```
          echo "============stop openclash============"
          uci set openclash.config.enable='0'
          uci commit openclash
          /etc/init.d/openclash start
          echo "============openclash stoped============"
          ```
      - 将最后一行 `/tmp/tailscale "$@"` 替换为以下命令：
        - ```
          /tmp/tailscale "$@" &  #后台运行tailscale
          echo "============start openclash============"
          sleep 10
          uci set openclash.config.enable='1'
          uci commit openclash
          /etc/init.d/openclash start
          echo "============openclash started============"
          ```

      - 其他工具请自行搜索 uci 命令。
