# Docker-YGOServer
在Docker容器中运行 [ygopro-server](https://github.com/mycard/srvpro) 或 [edopro-server](https://github.com/DyXel/Multirole)，支持x64、arm64与arm32架构

如果你要安装的是 [EDOPro](https://github.com/edo9300/edopro) 服务器，请看 --> [这里](https://github.com/Unicorn369/ygoserver/tree/edo)

如有问题请在这反馈 --> [这里](https://github.com/Unicorn369/ygoserver/issues)

## 安装运行
安装原版
```
docker run -d \
    -p 7911:7911 \
    -p 7922:7922 \
    -v $PWD/config:/ygoserver/config \
    -v $PWD/data:/ygoserver/ygopro/expansions \
    -v $PWD/plugins:/ygoserver/plugins \
    -v $PWD/decks:/ygoserver/decks \
    -v $PWD/replays:/ygoserver/replays \
    -v $PWD/logs:/root/.pm2/logs \
    --name=ygoserver \
    --restart=always \
    yunikon525/ygoserver:latest
```
安装koishi版
```
docker run -d \
    -p 7911:7911 \
    -p 7922:7922 \
    -v $PWD/config:/ygoserver/config \
    -v $PWD/data:/ygoserver/ygopro/expansions \
    -v $PWD/plugins:/ygoserver/plugins \
    -v $PWD/decks:/ygoserver/decks \
    -v $PWD/replays:/ygoserver/replays \
    -v $PWD/logs:/root/.pm2/logs \
    --name=ygoserver \
    --restart=always \
    yunikon525/ygoserver:koishi
```
安装SRVPro2
```
docker run -d \
    -p 7911:7911 \
    -p 7922:7922 \
    -v $PWD/config:/ygoserver/config \
    -v $PWD/data:/ygoserver/ygopro/expansions \
    -v $PWD/plugins:/ygoserver/plugins \
    -v $PWD/decks:/ygoserver/decks \
    -v $PWD/replays:/ygoserver/replays \
    -v $PWD/logs:/root/.pm2/logs \
    --name=ygoserver \
    --restart=always \
    yunikon525/ygoserver:srvpro2
```

## Arena 模式
已修补`Arena模式`，只需安装并配置 [ygopro-arena-api](https://hub.docker.com/r/yunikon525/ygopro-arena-api) 即可食用，无需开启 `mycard模式`

安装代码参考 (**请先安装 ygopro-arena-api容器，才能使用下代码**)
```
docker run -d \
    -e ENABLE_ARENA_MODE=1 \
    -e MYCARD_ARENA_MODE="athletic" \
    -e MYCARD_ARENA_ACCESS_KEY="key_passwd" \
    -e MYCARD_ARENA_POST_SCORE="http://$(ygopro-arena-api)" \
    -e MYCARD_ARENA_GET_SCORE="http://$(ygopro-arena-api)" \
    -p 7911:7911 \
    -p 7922:7922 \
    -v $PWD/config:/ygoserver/config \
    -v $PWD/data:/ygoserver/ygopro/expansions \
    -v $PWD/plugins:/ygoserver/plugins \
    -v $PWD/decks:/ygoserver/decks \
    -v $PWD/replays:/ygoserver/replays \
    -v $PWD/logs:/root/.pm2/logs \
    --name=ygoserver \
    --restart=always \
    yunikon525/ygoserver:latest
```

## 其他说明
  * 端口
    * `7911`: YGOPro端口
    * `7922`: 管理后台端口 （请登录 http://(ip):7980）
    * `7933`: 竞赛模式端口 （请登录 http://(ip):7980）
    * `7980`: web端口
      * 需配置环境变量 `ENABLE_API=1`(启用本地web) 与 `API_PASS=123456789`(设置密码)

  * 目录说明
    * `$PWD/data`: YGOPro卡片数据卷
    * `$PWD/config`: YGOServer配置文件数据卷
    * `$PWD/plugins`: YGOServer插件目录
    * `$PWD/decks`: 竞赛模式卡组数据卷
    * `$PWD/replays`: 竞赛模式录像数据卷
    * `$PWD/logs`: 运行日志
