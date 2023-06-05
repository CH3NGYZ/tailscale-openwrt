# 在 openwrt 上最简单的 tailscale 部署方法
# The easiest way to deploy tailscale on openwrt
## 仅兼容 aarch64、x86_64、mips、armv7l

[![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

### 0x00 安装

```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

### 0x01 卸载
请注意不要在远程连接时卸载，会丢失ssh连接。 Use at your own risk
```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
```

### 0x02 更新

```
reboot
```

### 0x03 troubleshoot

- ghproxy.net 无法链接，或链接极慢

  - 先在其他设备上`curl ghproxy.net`,如果有显示 html 基本结构，则ghproxy链接正常。
  - 如果ghproxy.net链接正常，则可能是*openclash*等翻墙工具影响了*ghproxy*。 
    - 如果安装时无法下载，请考虑停止翻墙工具，再安装。
    - 如果开机时无法下载，请考虑修改启动脚本/usr/bin/tailscale和/usr/bin/tailscaled。 
      - 以 openclash 为例，在脚本第二行添加禁用翻墙工具的命令：
        ```
        echo "============stop openclash============"
        uci set openclash.config.enable='0'
        uci commit openclash
        /etc/init.d/openclash stop
        echo "============openclash stoped============"
        ```
      - 将最后一行 /tmp/tailscale "$@" 替换为以下命令：
        ```
        /tmp/tailscale "$@" &  #后台运行tailscale
        echo "============start openclash============"
        sleep 10
        uci set openclash.config.enable='1'
        uci commit openclash
        /etc/init.d/openclash start
        echo "============openclash started============"
        ```
      - 其他工具请自行搜索 uci 命令。这里提供一个通用方法：
        - 1 以passwall为例，查找/etc/config下的passwall配置文件，记住这个配置文件的名字passwall。 
        - 2 ssh输入uci show 配置文件名（uci show passwall），会出现很多配置项，这里找一下有没有enabled之类的关键词，那极有可能就是控制passwall开关的语句 
        - 3 去管理页面关闭passwall 
        - 4 打开/etc/config/passwall备用 
        - 5 去管理页面打开passwall 
        - 6 再次打开/etc/config/passwall 
        - 7 可以发现新出现了一条`option enabled '1'`，这一条就是开关passwall的配置。 
        - 8 即passwall文件中global区块内有个enabled的选项，为“1”则开启，为“0”则关闭。 
        - 9 在2的结果中找一下符合或类似 `<配置文件名 passwall>.<区块名 global>.<选项名 enabled>=<值>` 的格式的语句，假如我找到了passwall.@global[0].enabled="0"。 
        - 10 开关命令： 
          - 开启： 
            - uci set passwall.@global[0].enabled="1" 
            - uci commit passwall 
          - 关闭：  
            - uci set passwall.@global[0].enabled="0" 
            - uci commit passwall
        - more information, pls visit [this page](https://www.cnblogs.com/v5captain/p/16175769.html)
### 如果好用，麻烦动动小手点个Star，谢谢啦！
