#!/bin/sh
SRVPRO_PATH=/ygoserver
SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-bot-no.json

ENABLE_API="${ENABLE_API:-}"
API_PASS="${API_PASS:-}"

DB_HOST="${DB_HOST:-}"
DB_PORT="${DB_PORT:-}"
DB_USER="${DB_USER:-}"
DB_PASS="${DB_PASS:-}"
DB_NAME="${DB_NAME:-}"

ENABLE_CLOUD_REPLAY="${ENABLE_CLOUD_REPLAY:-}"

ENABLE_WINDBOT_BUILT="${ENABLE_WINDBOT_BUILT:-}"
ENABLE_WINDBOT="${ENABLE_WINDBOT:-}"
WINDBOT_PORT="${WINDBOT_PORT:-}"
WINDBOT_MY_IP="${WINDBOT_MY_IP:-}"
WINDBOT_SERVER_IP="${WINDBOT_SERVER_IP:-}"

TOURNAMENT_MODE="${TOURNAMENT_MODE:-}"

ENABLE_ARENA_MODE="${ENABLE_ARENA_MODE:-}"
MYCARD_ARENA_MODE="${MYCARD_ARENA_MODE:-}"
MYCARD_ARENA_ACCESS_KEY="${MYCARD_ARENA_ACCESS_KEY:-}"
#MYCARD_ARENA_CHECK_PERMIT="${MYCARD_ARENA_CHECK_PERMIT:-}"
MYCARD_ARENA_POST_SCORE="${MYCARD_ARENA_POST_SCORE:-}"
MYCARD_ARENA_GET_SCORE="${MYCARD_ARENA_GET_SCORE:-}"

install_mono() {
    if [ "$(cat /etc/apk/arch)" = "armv7" ]; then
        echo "arm: Not Supported"
    else
        echo "开始安装 MONO"
        apk add --no-cache --repository https://mirrors.aliyun.com/alpine/edge/community mono
    fi
}

set_config() {
    jq $1 "$SRVPRO_PATH/config/config.json" > "$SRVPRO_PATH/config/config.json.tmp"
    mv -f "$SRVPRO_PATH/config/config.json.tmp" "$SRVPRO_PATH/config/config.json"
}

get_config() {
    cat "$SRVPRO_PATH/config/config.json" | jq $1
}

set_config_admin() {
    jq $1 "$SRVPRO_PATH/config/admin_user.json" > "$SRVPRO_PATH/config/admin_user.json.tmp"
    mv -f "$SRVPRO_PATH/config/admin_user.json.tmp" "$SRVPRO_PATH/config/admin_user.json"
}

is_enabled() {
    case "$1" in
        1|[Tt][Rr][Uu][Ee]) return 0 ;;
        *) return 1 ;;
    esac
}

run_server() {
  pm2-docker start $SRVPRO_SCRIPT
}

# 检测文件是否存在
if [ ! -f "$SRVPRO_PATH/config/config.json" ]; then
    mkdir -p $SRVPRO_PATH/config/
    cp -rf "$SRVPRO_PATH/data/default_config.json" "$SRVPRO_PATH/config/config.json"
fi
if [ ! -f "$SRVPRO_PATH/config/admin_user.json" ]; then
    mkdir -p $SRVPRO_PATH/config/
    jq .users "$SRVPRO_PATH/data/default_data.json" > "$SRVPRO_PATH/config/admin_user.json"
fi
if [ ! -f "$SRVPRO_PATH/windbot/cards.cdb" ]; then
    ln -s "$SRVPRO_PATH/ygopro/cards.cdb" "$SRVPRO_PATH/windbot/cards.cdb"
fi

for arg in "$@"; do
    case $arg in
        --version)
            echo "YGOServer Build 2026/06/18"
            shift && exit
            ;;
        --install-mono|mono)
            install_mono
            shift && exit
            ;;
        --default-script=*)
            key="${arg#*=}"
            SRVPRO_SCRIPT=$key
            ;;
        --install-package=*)
            key="${arg#*=}"
            npm install $key
            ;;
        --ygo-windbot=*)
            key="${arg#*=}"
            ENABLE_WINDBOT_BUILT=$key
            ;;
        -*|--*)
            echo "Illegal option $1"
            ;;
    esac
    shift
done
#—————————— DB ——————————
if [ -n "$DB_HOST" ]; then
    set_config ".modules.mysql.db.host=\"$DB_HOST\""
fi
if [ -n "$DB_PORT" ]; then
    set_config ".modules.mysql.db.port=$DB_PORT"
fi
if [ -n "$DB_USER" ]; then
    set_config ".modules.mysql.db.username=\"$DB_USER\""
fi
if [ -n "$DB_PASS" ]; then
    set_config ".modules.mysql.db.password=\"$DB_PASS\""
fi
if [ -n "$DB_NAME" ]; then
    set_config ".modules.mysql.db.database=\"$DB_NAME\""
fi
#—————————— API ——————————
if [ ! -n "$ENABLE_API" ]; then
    ENABLE_API=$(get_config .users.root.enabled)
fi
if [ -n "$ENABLE_API" ]; then
    if is_enabled "${ENABLE_API}"; then
        SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-bot-no.json
        set_config_admin ".users.root.enabled=true"
    else
        set_config_admin ".users.root.enabled=false"
    fi
fi
if [ -n "$API_PASS" ]; then
    set_config_admin ".users.root.password=\"$API_PASS\""
fi
#—————————— CLOUD_REPLAY ——————————
if [ -n "$ENABLE_CLOUD_REPLAY" ]; then
    if is_enabled "${ENABLE_CLOUD_REPLAY}"; then
        set_config ".modules.mysql.enabled=true"
        set_config ".modules.cloud_replay.enabled=true"
    else
        set_config ".modules.mysql.enabled=false"
        set_config ".modules.cloud_replay.enabled=false"
    fi
fi
#—————————— WINDBOT ——————————
if [ -n "$ENABLE_WINDBOT_BUILT" ]; then
    if is_enabled "${ENABLE_WINDBOT_BUILT}"; then
        install_mono
        SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-bot-yes.json
        if [ "$(jq .users.root.enabled $SRVPRO_PATH/config/admin_user.json)" = 'true' ]; then
            SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-bot-yes.json
        fi
        set_config ".modules.windbot.server_ip=\"127.0.0.1\""
        set_config ".modules.windbot.my_ip=\"127.0.0.1\""
    fi
fi
if [ -n "$ENABLE_WINDBOT" ]; then
    if is_enabled "${ENABLE_WINDBOT}"; then
        set_config ".modules.windbot.enabled=true"
    else
        set_config ".modules.windbot.enabled=false"
    fi
fi
if [ -n "$WINDBOT_PORT" ]; then
    set_config ".modules.windbot.port=$WINDBOT_PORT"
fi
if [ -n "$WINDBOT_MY_IP" ]; then
    set_config ".modules.windbot.my_ip=\"$WINDBOT_MY_IP\""
fi
if [ -n "$WINDBOT_SERVER_IP" ]; then
    set_config ".modules.windbot.server_ip=\"$WINDBOT_SERVER_IP\""
fi
#—————————— TOURNAMENT_MODE ——————————
if [ ! -n "$TOURNAMENT_MODE" ]; then
    TOURNAMENT_MODE=$(get_config .modules.tournament_mode.enabled)
fi
if [ -n "$TOURNAMENT_MODE" ]; then
    if is_enabled "${TOURNAMENT_MODE}"; then
        SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-tournament.json
        if [ "$key" = "true" && "$(jq .users.root.enabled $SRVPRO_PATH/config/admin_user.json)" = 'true' ]; then
            SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-tournament.json
        fi
        set_config ".modules.tournament_mode.enabled=true"
    else
        set_config ".modules.tournament_mode.enabled=false"
    fi
fi
#—————————— ARENA_MODE ——————————
if [ ! -n "$ENABLE_ARENA_MODE" ]; then
    ENABLE_ARENA_MODE=$(get_config .modules.arena_mode.enabled)
fi
if [ -n "$ENABLE_ARENA_MODE" ]; then
    mkdir -p $SRVPRO_PATH/plugins
    if is_enabled "${ENABLE_ARENA_MODE}"; then
        cp -rf $SRVPRO_PATH/data-start/login.js $SRVPRO_PATH/plugins/arena_login.js
        patch -N -d $SRVPRO_PATH < $SRVPRO_PATH/data-start/arena-fix.patch
        set_config ".modules.arena_mode.enabled=true"
    else
        rm -rf $SRVPRO_PATH/plugins/arena_login.js
        patch -R -N -d $SRVPRO_PATH < $SRVPRO_PATH/data-start/arena-fix.patch
        set_config ".modules.arena_mode.enabled=false"
    fi
fi
if [ -n "$MYCARD_ARENA_MODE" ]; then
    set_config ".modules.arena_mode.mode=\"$MYCARD_ARENA_MODE\""
fi
if [ -n "$MYCARD_ARENA_ACCESS_KEY" ]; then
    set_config ".modules.arena_mode.accesskey=\"$MYCARD_ARENA_ACCESS_KEY\""
fi
#if [ -n "$MYCARD_ARENA_CHECK_PERMIT" ]; then
#    set_config ".modules.arena_mode.check_permit=\"$MYCARD_ARENA_CHECK_PERMIT\""
#fi
if [ -n "$MYCARD_ARENA_POST_SCORE" ]; then
    set_config ".modules.arena_mode.post_score=\"$MYCARD_ARENA_POST_SCORE\""
fi
if [ -n "$MYCARD_ARENA_GET_SCORE" ]; then
    set_config ".modules.arena_mode.get_score=\"$MYCARD_ARENA_GET_SCORE\""
fi
#—————————— RUN ——————————
run_server
#—————————— END ——————————