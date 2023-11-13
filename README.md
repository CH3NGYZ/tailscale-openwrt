# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  在OpenWRT上部署Tailscale的最简单方法 |
| ------------ |
|  已测试支持的架构：x86_64、mipsle |
|  未经测试的架构：aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、mipsle、i386、geode |

- 尽管我的[install.sh](https://github.com/CH3NGYZ/tailscale-openwrt/blob/chinese_mainland/install.sh)脚本中有预设aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、i386、geode这些架构的安装命令，但由于系统以及机器架构的不同，导致运行查看架构的命令 `uname -m` 出来的结果 ***可能*** 不是脚本中预设的内容，所以有可能因为对不上而查找架构失败，因此如果你能测试这个脚本，并在issues中通知运行的结果，我将尽快更新脚本，以及文档中支持的架构部分。
- 如果您想自定义脚本内容，请fork我的仓库，切换到相应的分支，修改/usr/bin/文件，将下载链接更改为您的仓库，Github Actions会自动将修改后的内容打包到tgz中，并将其上传到当前仓库。然后修改install.sh和Readme.MD文件中的用户名以指向您的仓库。
> [此分支的文件以及链接都添加了代理,如果手动运行tailscale发现2代理也下不动,请提issue联系我更换代理]()
> 
> 注意, clash for windows的TUN模式与DockerDesktop、Tailscale for Windows不兼容, 解决办法: 暂时关闭TUN, 登录完毕后再打开. [原理](https://chengyunzhe.notion.site/chengyunzhe/clash-for-windows-docker-tailscale-fccff782bd2c482cb9b7d3dd08c58b18)
------------

## 0x00 安装
```
wget --tries=5 -c -t 60 -O- https://cdn.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/install.sh | sh
```

------------

## 0x01 卸载
- ***请注意不要在ssh连接期间卸载，因为ssh连接将丢失！使用风险自负。***

```
wget --tries=5 -c -t 60 -O- https://cdn.jsdelivr.net/gh/CH3NGYZ/tailscale-openwrt@chinese_mainland/uninstall.sh | sh
```
------------
## 0x02 升级
- ***由于该脚本通过网络直接将TailScale的可执行文件的最新版本下载到内存中，因此每次启动openwrt时都会下载最新版本。***
```
reboot
```

------------
## 0x03 troubleshoot

- ghproxy.net 无法链接，或链接极慢

  - 先在其他设备上`curl ghproxy.com`,如果有显示 html 基本结构，则ghproxy链接正常。
  - 如果ghproxy.com链接正常，则可能是*openclash*等翻墙工具影响了*ghproxy*。 
    - 如果安装时无法下载，请考虑停止翻墙工具，再安装。
    - 如果开机时无法下载，请考虑修改启动脚本/usr/bin/tailscaled。 
      - 以 openclash 为例，在脚本第二行添加禁用翻墙工具的命令：
        ```
        echo "============stop openclash============"
        uci set openclash.config.enable='0'
        uci commit openclash
        /etc/init.d/openclash stop
        # /etc/rc.d/S99openclash stop
        echo "============openclash stoped============"
        ```
      - 将最后一行 /tmp/tailscale "$@" 替换为以下命令：
        ```
        /tmp/tailscaled "$@" &  #后台运行tailscale
        echo "============start openclash============"
        sleep 10
        uci set openclash.config.enable='1'
        uci commit openclash
        /etc/init.d/openclash start
        # /etc/rc.d/S99openclash start
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
        - 更多信息请访问[此页面](https://www.cnblogs.com/v5captain/p/16175769.html)
#### 如果好用，麻烦动动小手点个Star，谢谢啦！
------------
### 特别感谢:
[adyanth [openwrt-tailscale-enabler]](https://github.com/adyanth/openwrt-tailscale-enabler) 
