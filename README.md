# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  The easiest way to deploy tailscale on openwrt |
| ------------ |
|  Supported architectures have been tested ：x86_64, mipsle |
|  Untested architecture : aarch64、armv8l、armv7l、riscv64、mips、mips64、mips64le、i386、geode |

[简体中文说明文档](https://github.com/CH3NGYZ/tailscale-openwrt/tree/main/README_zh-cn.md) 

中国用户请使用[加了代理的脚本](https://github.com/CH3NGYZ/tailscale-openwrt/blob/chinese_mainland/README.md)
-  Although my [install.sh](https://github.com/CH3NGYZ/tailscale-openwrt/blob/main/install.sh) in the script has the preset *[aarch64, armv8l, armv7l, ris cv64, mips, mips64, mips64le, i386, geode]* these architecture installation commands, but due to the difference in system and machine architecture, the result of running the command 'uname -m' to view the architecture ***MAY NOT*** be the preset content in the script. So it's possible that the schema lookup fails because it doesn't match, so if you can test the script and notify the results of the run in issues, I'll update the script as soon as possible, along with the supported schema parts of the documentation.
- If you want to customize the script content, please fork my repository, switch to the appropriate branch, modify the /usr/bin/file, change the download link to your repository release, Github Actions will automatically package your modified content into tgz and upload it to the current repository. Then modify the install.sh and README.MD files to point to your repository.
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
