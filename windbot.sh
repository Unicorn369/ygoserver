#!/bin/sh
windbot_run() {
    if [ "$(uname -m)" = "x86_64" ]; then
        apk add --no-cache --repository https://mirrors.aliyun.com/alpine/edge/community mono
        cp -rf /srvpro/data/pm2-docker-bot-yes.json /srvpro/data/pm2-docker.json
        jq '.modules.windbot.enabled=true' /srvpro/config/config.json > /srvpro/config/config.json.tmp
        mv -f /srvpro/config/config.json.tmp /srvpro/config/config.json
        echo "amd64: OK"
    elif [ "$(uname -m)" = "aarch64" ]; then
        apk add --no-cache --repository https://mirrors.aliyun.com/alpine/edge/community mono
        cp -rf /srvpro/data/pm2-docker-bot-yes.json /srvpro/data/pm2-docker.json
        jq '.modules.windbot.enabled=true' /srvpro/config/config.json > /srvpro/config/config.json.tmp
        mv -f /srvpro/config/config.json.tmp /srvpro/config/config.json
        echo "arm64: OK"
    else
        cp -rf /srvpro/data/pm2-docker-bot-no.json /srvpro/data/pm2-docker.json
        jq '.modules.windbot.enabled=false' /srvpro/config/config.json > /srvpro/config/config.json.tmp
        mv -f /srvpro/config/config.json.tmp /srvpro/config/config.json
        echo "arm: Not Supported"
    fi
}

windbot_stop() {
    cp -rf /srvpro/data/pm2-docker-bot-no.json /srvpro/data/pm2-docker.json
    jq '.modules.windbot.enabled=false' /srvpro/config/config.json > /srvpro/config/config.json.tmp
    mv -f /srvpro/config/config.json.tmp /srvpro/config/config.json
    echo "windbot stop"
}

if [ ! -f "/usr/bin/jq" ]; then
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories
    apk add --no-cache jq
fi

if [ ! -f "/srvpro/config/config.json" ]; then
    cp -rf /srvpro/data/default_config.json /srvpro/config/config.json
fi

case "$1" in
    start)
        windbot_run
        ;;
    stop)
        windbot_stop
        ;;
    *)
        echo -e "\n请指定参数 (start | stop)"
        ;;
esac
