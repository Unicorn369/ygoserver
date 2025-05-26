# Docker-YGOServer
在Docker容器中运行 [ygopro-server](https://github.com/mycard/srvpro)，支持x64、arm64与arm32架构

如有问题请在这反馈 --> [这里](https://github.com/Unicorn369/ygoserver/issues)

## 安装运行
终端执行命令
```
docker run -d -p 7911:7911 -p 7922:7922 -p 7980:7980 -v $PWD/config:/ygoserver/config -v $PWD/expansions:/ygoserver/ygopro/expansions --name=YGOServer --restart=always yunikon525/ygoserver
```

## WindBot (人机对战服务)
启用人机对战功能，请在终端执行命令
```
docker exec -it YGOServer sh /ygoserver/windbot.sh start
```

关闭人机对战功能，请在终端执行命令
```
docker exec -it YGOServer sh /ygoserver/windbot.sh stop
```

**注意** 此功能需要安装`mono`，该容器默认没有安装，你可以选择在此容器安装，或者额外安装 [windbot](https://hub.docker.com/r/yunikon525/windbot) 容器

在此容器安装，请在终端执行命令
```
docker exec -it YGOServer sh /ygoserver/windbot.sh mono
```

不在此容器安装，而是额外安装[windbot](https://hub.docker.com/r/yunikon525/windbot)容器，则需要修改[配置文件](https://github.com/mycard/srvpro/blob/775ff463b715ca12e17dc5bb242eeabf775a17ce/data/default_config.json#L110)
```
docker run -d --name=WindBot --restart=always yunikon525/windbot
```

## 其他说明
  * 端口
    * `7911`: YGOPro端口
    * `7922`: 管理后台端口 （请登录 http://(ip):7980）
    * `7933`: 竞赛模式端口 （请登录 http://(ip):7980）
    * `7980`: web端口

  * 数据卷
    * `/ygoserver/config`: YGOServer配置文件数据卷
    * `/ygoserver/ygopro/expansions`: YGOPro额外卡片数据卷
    * `/ygoserver/decks`: 竞赛模式卡组数据卷
    * `/ygoserver/replays`: 竞赛模式录像数据卷
