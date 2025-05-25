#!/bin/sh
install_mono() {
    if [ "$(uname -m)" = "arm" ]; then
        echo "arm: Not Supported"
    else
        echo "开始安装 MONO"
        apk add --no-cache --repository https://mirrors.aliyun.com/alpine/edge/community mono
        windbot_start
    fi
}

windbot_start() {
    if [ ! -d "/ygoserver/windbot" ]; then
        unzip -o -qq /ygoserver/windbot.zip -d /ygoserver/
    fi
    if [ ! -f "/ygoserver/windbot/cards.cdb" ]; then
        ln -s /ygoserver/ygopro/cards.cdb /ygoserver/windbot/cards.cdb
    fi
    echo "Config: 开始修改配置文件"
    cp -rf /ygoserver/data/pm2-docker-bot-yes.json /ygoserver/data/pm2-docker.json
    jq '.modules.windbot.enabled=true' /ygoserver/config/config.json > /ygoserver/config/config.json.tmp
    mv -f /ygoserver/config/config.json.tmp /ygoserver/config/config.json
    echo "Config: 配置文件已变更，请重启Docker容器"
    echo "WindBot: 已启用"
}

windbot_stop() {
    echo "Config: 开始修改配置文件"
    cp -rf /ygoserver/data/pm2-docker-bot-no.json /ygoserver/data/pm2-docker.json
    jq '.modules.windbot.enabled=true' /ygoserver/config/config.json > /ygoserver/config/config.json.tmp
    mv -f /ygoserver/config/config.json.tmp /ygoserver/config/config.json
    echo "Config: 配置文件已变更，请重启Docker容器"
    echo "WindBot: 已禁用"
}

# 安装JQ命令
if [ ! -f "/usr/bin/jq" ]; then
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories
    apk add --no-cache jq
fi
# 检测文件是否存在
if [ ! -f "/ygoserver/config/config.json" ]; then
    cp -rf /ygoserver/data/default_config.json /ygoserver/config/config.json
fi

case "$1" in
    mono)
        install_mono
        ;;
    start)
        windbot_start
        ;;
    stop)
        windbot_stop
        ;;
    *)
        echo "\n请指定参数 (mono | start | stop)"
        ;;
esac
