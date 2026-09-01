#!/bin/sh
SRVPRO_PATH=/ygoserver
SRVPRO_SCRIPT=$SRVPRO_PATH/pm2-docker.json

run_server() {
cat > $SRVPRO_SCRIPT << 'INITEOF'
{
	"apps": [
		{
			"name": "ygoserver",
			"script": "/ygoserver/dist/index.js",
			"cwd": "/ygoserver"
		}
	]
}
INITEOF

  pm2-docker start $SRVPRO_SCRIPT
}

# 检测文件是否存在
rm -rf $SRVPRO_PATH/data
mkdir -p $SRVPRO_PATH/config
ln -sf $SRVPRO_PATH/config $SRVPRO_PATH/data
if [ ! -f "$SRVPRO_PATH/config/config.yaml" ]; then
    cp -rf $SRVPRO_PATH/config.yaml $SRVPRO_PATH/config/config.yaml
fi
if [ -f "$SRVPRO_PATH/config/config.yaml" ]; then
    cp -rf $SRVPRO_PATH/config/config.yaml $SRVPRO_PATH/config.yaml
fi

for arg in "$@"; do
    case $arg in
        --version)
            echo "SRVPro2 2026/09/01"
            shift && exit
            ;;
        -*|--*)
            echo "Illegal option $1"
            ;;
    esac
    shift
done

#—————————— RUN ——————————
run_server
#—————————— END ——————————