# Tailscale on OpenWRT :smiley: [![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV)

|  在 openwrt 上最简单的 tailscale 部署方法  | The easiest way to deploy tailscale on openwrt |
| ------------ | ------------ |
|  仅兼容 aarch64、x86_64、mips、armv7l |   Only compatible with aarch64, x86_64, mips, armv7l |

> Note: 由于国内raw.githubusercontent.com无法访问, 请国内用户使用 [国内优化分支](https://github.com/cyz0105/tailscale-openwrt/tree/chinese_mainland) 

------------

## 0x00 Install
```
wget -O- https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

------------

## 0x01 Uninstall
- ***please be careful not to uninstall during an ssh connection, as the ssh connection will be lost. use at your own risk.***

```
wget -O- https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
```
------------
## 0x02 Upgrade
```
reboot
```
------------
### Special thanks:
[adyanth [openwrt-tailscale-enabler]](https://github.com/adyanth/openwrt-tailscale-enabler) 
