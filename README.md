# 在openwrt上最简单的tailscale部署方法
[![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV "")

### 只需设定cron每天运行tailscale up命令即可自动同步最新版。
### 目前脚本为了兼容openclash，特意改写了启动规则，即先停用openclash，再下载最新版tailscale，然后再启动openclash，如您在使用中有任何问题，请提起issue，我会尽快解决。
## 在SSH里运行以下命令:
### 安装
```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

### 卸载
```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
```
