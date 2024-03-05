# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  在OpenWRT上部署Tailscale的最简单方法 |
| ------------ |
|  已测试支持的架构：x86_64、mipsle |
|  未经测试的架构：aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、mipsle、i386、geode |

- 尽管我的[install.sh](https://github.com/CH3NGYZ/tailscale-openwrt/blob/chinese_mainland/install.sh)脚本中有预设aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、i386、geode这些架构的安装命令，但由于系统以及机器架构的不同，导致运行查看架构的命令 `uname -m` 出来的结果 ***可能*** 不是脚本中预设的内容，所以有可能因为对不上而查找架构失败，因此如果你能测试这个脚本，并在issues中通知运行的结果，我将尽快更新脚本，以及文档中支持的架构部分。
- 如果您想自定义脚本内容，请fork我的仓库，切换到相应的分支，修改/usr/bin/文件，将下载链接更改为您的仓库，Github Actions会自动将修改后的内容打包到tgz中，并将其上传到当前仓库。然后修改install.sh和Readme.MD文件中的用户名以指向您的仓库。
> [此分支的安装脚本及tailscale下载器都添加了多个代理, 如果代理全部失效, 请提issue联系我更换代理](https://github.com/CH3NGYZ/tailscale-openwrt/issues/7)
> 
![image](https://github.com/CH3NGYZ/tailscale-openwrt/assets/56500405/3823d18e-ccfd-459f-a45d-b451b8160ced)

> 注：clash for windows/clash verge的TUN模式与DockerDesktop、Tailscale for Windows不兼容, 解决办法: 暂时关闭TUN, 登录/使用完毕后再打开.
>  [原理](https://chengyunzhe.notion.site/chengyunzhe/clash-for-windows-docker-tailscale-fccff782bd2c482cb9b7d3dd08c58b18)
------------

## 0x00 安装
全新安装
```
wget -qO- https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh | sh
```



------------

## 0x01 卸载
- ***请注意不要在ssh连接期间卸载，因为ssh连接将丢失！使用风险自负。***

```
wget -qO- https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/uninstall.sh | sh
```
------------
## 0x02 升级
- 升级tailscale
- ***每次启动openwrt时tailscale_downloader都会通过网络下载最新版本的TailScale的可执行文件。***
```shell
reboot
```

- 保留配置升级
- ***如果下载器脚本(tailscale_downloader)存在版本更新(更新代理地址等), 运行以下命令更新最新下载器脚本***:
```
rm -rf /tmp/tailscale* && wget -qO- https://ghproxy.net/https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/chinese_mainland/install.sh | sh && reboot
```
------------
## 0x03 troubleshoot

- ghproxy.net 无法链接，或链接极慢

  - 先在其他设备上`curl ghproxy.com`,如果有显示 html 基本结构，则ghproxy链接正常。
  - 如果ghproxy.com链接正常，则可能是*openclash*等翻墙工具影响了*ghproxy*。 
    - 如果安装时无法下载，请考虑停止翻墙工具，再安装。
#### 如果好用，麻烦动动小手点个Star，谢谢啦！
------------
### 特别感谢:
[adyanth [openwrt-tailscale-enabler]](https://github.com/adyanth/openwrt-tailscale-enabler) 
