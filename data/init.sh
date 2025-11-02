#!/bin/sh
SERVER_PATH=/edoserver

set_config() {
    jq $1 "$SERVER_PATH/config/config.json" > "$SERVER_PATH/config/config.json.tmp"
    mv -f "$SERVER_PATH/config/config.json.tmp" "$SERVER_PATH/config/config.json"
}

set_config_url() {
    js_length=`cat "$SERVER_PATH/config/config.json" | jq .repos | jq 'length'`
    for i in $(seq 0 $(expr $js_length - 1))
    do
        if [[ `cat "$SERVER_PATH/config/config.json" | jq .repos[$i].name` == "\"$1\"" ]] ; then
            jq ".repos[$i].remote=\"$2\"" "$SERVER_PATH/config/config.json" > "$SERVER_PATH/config/config.json.tmp"
            mv -f "$SERVER_PATH/config/config.json.tmp" "$SERVER_PATH/config/config.json"
            break
        fi
    done
}

run_server() {
  ./multirole > tmp/server.log
}

cd $SERVER_PATH
# 检测文件是否存在
if [ ! -f "$SERVER_PATH/config/config.json" ]; then
    mkdir -p $SERVER_PATH/config/
    cp -rf "$SERVER_PATH/etc/config.json" "$SERVER_PATH/config/config.json"
fi
if [ ! -f "$SERVER_PATH/config.json" ]; then
    ln -s "$SERVER_PATH/config/config.json" "$SERVER_PATH/config.json"
fi
# 
if [ "$(cat /etc/apk/arch)" = "armv7" ]; then
    set_config ".coreProvider.fileRegex=\".*libocgcore\\\\.arm.so\""
    set_config_url "bin" "https://github.com/Unicorn369/edopro-core-bin"
elif [ "$(cat /etc/apk/arch)" = "aarch64" ]; then
    set_config ".coreProvider.fileRegex=\".*libocgcore\\\\.aarch64.so\""
else
    set_config ".coreProvider.fileRegex=\".*libocgcore\\\\.so\""
fi

for arg in "$@"; do
    case $arg in
        --version)
            echo "Multirole 2025/11/02"
            shift && exit
            ;;
        --default)
            echo "init..."
            rm -rf $SERVER_PATH/tmp/*
            ;;
        --update)
            wget -O /dev/null http://localhost:10000/up-scripts
            wget -O /dev/null http://localhost:10001/up-databases
            wget -O /dev/null http://localhost:10002/up-banlists
            wget -O /dev/null http://localhost:10003/up-bin
            shift && exit
            ;;
        --url-scripts=*)
            key="scripts"
            url="${arg#*=}"
            set_config_url $key $url
            ;;
        --url-databases=*)
            key="databases"
            url="${arg#*=}"
            set_config_url $key $url
            ;;
        --url-banlists=*)
            key="banlists"
            url="${arg#*=}"
            set_config_url $key $url
            ;;
        --url-bin=*)
            key="bin"
            url="${arg#*=}"
            set_config_url $key $url
            ;;
        -*|--*)
            echo "Illegal option $1"
            ;;
    esac
    shift
done

run_server
