# Docker-YGOServer
在Docker容器中运行 [edopro-server](https://github.com/DyXel/Multirole)，支持x64、arm64与arm32架构

## 安装运行
终端执行命令
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/ygoserver/config -v $PWD/replays:/ygoserver/replays -v $PWD/sync:/ygoserver/sync -v $PWD/tmp:/ygoserver/tmp --name=edoserver --restart=always yunikon525/ygoserver:edo
```

## 参数说明
 * --url-scripts=https://github.com/ProjectIgnis/CardScripts
   * 设置 scripts 源
 * --url-databases=https://github.com/ProjectIgnis/BabelCDB
   * 设置 databases 源
 * --url-banlists=https://github.com/ProjectIgnis/LFLists
   * 设置 banlists 源
 * --url-bin=https://github.com/Unicorn369/edopro-core-bin
   * 设置 bin 源

## 其他说明
  * 端口
    * `7911`: duelport
    * `7922`: roomlistport

  * 数据卷
    * `/ygoserver/config`: 配置文件数据卷
    * `/ygoserver/replays`: 录像文件数据卷
    * `/ygoserver/sync`: Server数据卷
    * `/ygoserver/tmp`: tmp数据卷
