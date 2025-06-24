#!/bin/sh
SERVER_PATH=/ygoserver

set_config() {
    jq $1 "$SERVER_PATH/config/config.json" > "$SERVER_PATH/config/config.json.tmp"
    mv -f "$SERVER_PATH/config/config.json.tmp" "$SERVER_PATH/config/config.json"
}

run_server() {
  ./multirole
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
elif [ "$(cat /etc/apk/arch)" = "aarch64" ]; then
    set_config ".coreProvider.fileRegex=\".*libocgcore\\\\.aarch64.so\""
else
    set_config ".coreProvider.fileRegex=\".*libocgcore\\\\.so\""
fi

for arg in "$@"; do
    case $arg in
        --version)
            echo "Multirole 2025/06/24"
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
        -*|--*)
            echo "Illegal option $1"
            ;;
    esac
    shift
done

run_server
