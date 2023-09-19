# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  The easiest way to deploy tailscale on openwrt |
| ------------ |
|  Supported architectures have been tested ：x86_64 |
|  Untested architecture : aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、mipsle、i386、geode |

[简体中文](https://github.com/CH3NGYZ/tailscale-openwrt/edit/main/README_zh-cn.md)
- **Hope you will test this script and inform me of the running results in issue. I will update the supported architecture parts of the documentation as soon as possible.**
- If you want to customize the script content, please fork my repository, switch to the appropriate branch, modify the /usr/bin/file, change the download link to your repository release, Github Actions will automatically package your modified content into tgz and upload it to the current repository. Then modify the install.sh and README.MD files to point to your repository.
> Note: 由于国内 raw.githubusercontent.com 被DNS污染, 如您使用main分支的脚本出现超时情况， 请考虑使用 [Github代理分支](https://github.com/CH3NGYZ/tailscale-openwrt/tree/chinese_mainland) 
------------

## 0x00 Install
```
wget --tries=5 -c -t 60 -O- https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/main/install.sh | sh
```

------------

## 0x01 Uninstall
- ***Please be careful not to uninstall during an ssh connection, as the ssh connection WILL BE LOST ! use at your own risk.***

```
wget --tries=5 -c -t 60 -O- https://raw.githubusercontent.com/CH3NGYZ/tailscale-openwrt/main/uninstall.sh | sh
```
------------
## 0x02 Upgrade
- ***Since this script downloads the latest version of tailscale's executable file directly over the network to /tmp, the latest version is downloaded every time you boot up.***
```
reboot
```
------------
### Special thanks:
[adyanth [openwrt-tailscale-enabler]](https://github.com/adyanth/openwrt-tailscale-enabler) 
