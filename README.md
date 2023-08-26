# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  在 openwrt 上最简单的 tailscale 部署方法  | The easiest way to deploy tailscale on openwrt |
| ------------ | ------------ |
|  仅兼容 aarch64、x86_64、mips、armv7l |   Only compatible with aarch64, x86_64, mips, armv7l |

- If you want to customize the script content, please clone my repository, switch to the appropriate branch, modify the /usr/bin/file, change the download link to your repository release, Github Actions will automatically package your modified content into tgz and upload it to the current repository. Then modify the install.sh and README.MD files to point to your repository.
> Note: 由于国内raw.githubusercontent.com无法访问, 请国内用户使用 [国内优化分支](https://github.com/cyz0105/tailscale-openwrt/tree/chinese_mainland) 
------------

## 0x00 Install
```
wget -O- https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

------------

## 0x01 Uninstall
- ***Please be careful not to uninstall during an ssh connection, as the ssh connection WILL BE LOST ! use at your own risk.***

```
wget -O- https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
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
