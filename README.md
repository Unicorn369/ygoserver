# Docker-Rrvpro
在Docker容器中运行 [ygopro-server](https://github.com/mycard/srvpro)

小白或使用树莓派者，可搭配 [casaOS](https://casaos.zimaspace.com) 轻松管理你的Docker容器

## 安装运行
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/srvpro/config -v $PWD/expansions:/srvpro/ygopro/expansions --name=srvpro --restart=always yunikon525/ygoserver
```

## 支持的架构
linux                |  
---------------------|
amd64, x86_64        |
arm64, aarch64       |
armhf, armv7, armv7l |

## 其他说明
由于运行人机服务`WindBot`需要安装`mono`，大约会占用磁盘200~300M，所以Docker容器默认没有安装

如需启用人机对战功能，请在Docker容器执行命令 (注：armv7架构无`mono`)
```
docker exec -it $(容器ID) sh /srvpro/windbot.sh start
```
