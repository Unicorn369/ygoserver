# Docker-YGOServer
在Docker容器中运行 [ygopro-server](https://github.com/mycard/srvpro)，支持x64、arm64与arm32架构

小白或使用树莓派者，可搭配 [casaOS](https://casaos.zimaspace.com) 轻松管理你的Docker容器

## 使用 Docker
终端执行命令
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/ygoserver/config -v $PWD/expansions:/ygoserver/ygopro/expansions --name=YGOServer --restart=always yunikon525/ygoserver
```

## 使用 casaOS
通常使用`Docker`安装后，进入`casaOS`即可导入

或者进入`casaOS`点击 **`App  +`** 选择 **`安装自定义应用`**

名称        | 参数1 | 参数2 | 参数3 |
-----------|----------|-----|------|
Docker 镜像 | yunikon525/ygoserver | | |
Tag        | latest | | |
标题        | YGOServer | | |
网络        | Bridge | | |
端口        | 7911‌ | 7911 | TCP |
端口        | 7912‌ | 7912 | TCP |
卷        | /DATA/ygoserver/expansions‌ | /ygoserver/ygopro/expansions | |
卷        | /DATA/ygoserver/config‌ | /ygoserver/ygopro/config | |
容器命令   | pm2-docker‌ | start | /srvpro/data/pm2-docker.json |
重启策略   | always | | |
容器名     | YGOServer | | |

(提示: **端口** 点击2次添加，**卷** 点击2次添加，**容器命令** 点击3次添加。)

## 其他说明(WindBot)
如需启用人机对战功能，请终端执行命令
```
docker exec -it YGOServer sh /ygoserver/windbot.sh start
```

如需关闭人机对战功能，请终端执行命令
```
docker exec -it YGOServer sh /ygoserver/windbot.sh stop
```

**注意** 由于运行人机服务`WindBot`需要安装`mono`，大约会占用磁盘200~300M，该容器默认没有安装，所以你可能需要额外安装 [windbot](https://hub.docker.com/r/yunikon525/windbot)容器，或手动安装mono

如果你不想额外安装windbot容器，请终端执行命令 (注: arm32无法安装)

```
docker exec -it YGOServer sh /ygoserver/windbot.sh mono
```
