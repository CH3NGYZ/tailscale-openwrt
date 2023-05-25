# 在openwrt上最简单的tailscale部署方法
## 仅兼容 aarch64、x86-64、mips、armv7l
[![Page Views Count](https://badges.toozhao.com/badges/01GZWH4F36G14VWXT8RP9KRCYV/green.svg)](https://badges.toozhao.com/stats/01GZWH4F36G14VWXT8RP9KRCYV "")

### 部署后，如有新版本，只需直接重启路由器系统，会自动更新最新版。
### 如果您在使用本脚本前开启了openclash或类似服务，则ghproxy可能无法链接，或链接极慢，请考虑先禁用相应工具，再安装。
### 如果您在使用过程中，出现tailscale开机无法启动，可能是翻墙工具阻断了ghproxy，请考虑修改启动脚本/usr/bin/tailscale和/usr/bin/tailscaled，考虑在脚本开始添加禁用翻墙工具的命令，在echo “done” 之后添加启用翻墙工具的命令。
## 在SSH里运行以下命令:
### 安装
```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/install.sh | sh
```

### 卸载
```
wget -O- https://ghproxy.net/https://raw.githubusercontent.com/cyz0105/tailscale-openwrt/main/uninstall.sh | sh
```
