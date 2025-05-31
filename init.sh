#!/bin/sh
SRVPRO_PATH=/ygoserver
SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-bot-no.json

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

set_config_admin() {
    jq $1 "$SRVPRO_PATH/config/admin_user.json" > "$SRVPRO_PATH/config/admin_user.json.tmp"
    mv -f "$SRVPRO_PATH/config/admin_user.json.tmp" "$SRVPRO_PATH/config/admin_user.json"
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
        --install-mono|mono)
            install_mono
            ;;
        --default)
            SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-bot-no.json
            ;;
        --ygo-web=*)
            key="${arg#*=}"
            if [ "$key" = "true" ]; then
                SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-bot-no.json
            fi
            set_config_admin ".users.root.enabled=$key"
            ;;
        --ygo-web-passwd=*)
            key="${arg#*=}"
            set_config_admin ".users.root.password=\"$key\""
            ;;
        --ygo-windbot=*)
            key="${arg#*=}"
            if [ "$key" = "true" ]; then
                install_mono
                SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-bot-yes.json
            fi
            if [ "$(jq .users.root.enabled $SRVPRO_PATH/config/admin_user.json)" = 'true' ]; then
                SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-bot-yes.json
            fi
            ;;
        --ygo-lflist=*)
            key="${arg#*=}"
            set_config ".hostinfo.lflist=$key"
            ;;
        --ygo-card-rule=*|--ygo-rule=*)
            key="${arg#*=}"
            set_config ".hostinfo.rule=$key"
            ;;
        --ygo-mode=*)
            key="${arg#*=}"
            set_config ".hostinfo.mode=$key"
            ;;
        --ygo-duel-rule=*)
            key="${arg#*=}"
            set_config ".hostinfo.duel_rule=$key"
            ;;
        --ygo-lp=*)
            key="${arg#*=}"
            set_config ".hostinfo.start_lp=$key"
            ;;
        --ygo-start-hand=*)
            key="${arg#*=}"
            set_config ".hostinfo.start_hand=$key"
            ;;
        --ygo-draw-count=*)
            key="${arg#*=}"
            set_config ".hostinfo.draw_count=$key"
            ;;
        --ygo-time=*)
            key="${arg#*=}"
            set_config ".hostinfo.time_limit=$key"
            ;;
        --welcome=*)
            key="${arg#*=}"
            set_config ".modules.welcome=\"$key\""
            ;;
        --tips-url=*)
            key="${arg#*=}"
            set_config ".modules.tips.get=\"$key\""
            ;;
        --dialogues-url=*)
            key="${arg#*=}"
            set_config ".modules.dialogues.get_custom=\"$key\""
            ;;
        --chat-color=*)
            key="${arg#*=}"
            set_config ".modules.chat_color.enabled=$key"
            ;;
        --chat-color-vip=*)
            key="${arg#*=}"
            set_config ".modules.chat_color.restrict_to_vip=$key"
            set_config ".modules.vip.enabled=$key"
            ;;
        --random-duel=*)
            key="${arg#*=}"
            set_config ".modules.random_duel.enabled=$key"
            ;;
        --cloud-replay=*)
            key="${arg#*=}"
            set_config ".modules.mysql.enabled=$key"
            set_config ".modules.cloud_replay.enabled=$key"
            ;;
        --mysql-host=*)
            key="${arg#*=}"
            set_config ".modules.mysql.db.host=\"$key\""
            ;;
        --mysql-port=*)
            key="${arg#*=}"
            set_config ".modules.mysql.db.port=$key"
            ;;
        --mysql-user=*)
            key="${arg#*=}"
            set_config ".modules.mysql.db.username=\"$key\""
            ;;
        --mysql-passwd=*)
            key="${arg#*=}"
            set_config ".modules.mysql.db.password=\"$key\""
            ;;
        --mysql-db=*)
            key="${arg#*=}"
            set_config ".modules.mysql.db.database=\"$key\""
            ;;
        --windbot=*)
            key="${arg#*=}"
            set_config ".modules.windbot.enabled=$key"
            ;;
        --windbot-port=*)
            key="${arg#*=}"
            set_config ".modules.windbot.port=$key"
            ;;
        --windbot-ip=*)
            key="${arg#*=}"
            set_config ".modules.windbot.server_ip=\"$key\""
            set_config ".modules.windbot.my_ip=\"$(hostname -i)\""
            ;;
        --tournament=*)
            if [ "$key" = "true" ]; then
                SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-tournament.json
            fi
            if [ "$(jq .users.root.enabled $SRVPRO_PATH/config/admin_user.json)" = 'true' ]; then
                SRVPRO_SCRIPT=$SRVPRO_PATH/data-start/pm2-docker-web-tournament.json
            fi
            key="${arg#*=}"
            set_config ".modules.tournament_mode.enabled=$key"
            ;;
        --default-script=*)
            key="${arg#*=}"
            SRVPRO_SCRIPT=$key
            ;;
        -*|--*)
            echo "Illegal option $1"
            ;;
    esac
    shift
done

run_server
