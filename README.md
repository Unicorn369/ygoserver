# Docker-YGOServer
在Docker容器中运行 [ygopro-server](https://github.com/mycard/srvpro)，支持x64、arm64与arm32架构

如有问题请在这反馈 --> [这里](https://github.com/Unicorn369/ygoserver/issues)

## 安装运行
安装原版
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/ygoserver/config -v $PWD/expansions:/ygoserver/ygopro/expansions --name=ygoserver --restart=always yunikon525/ygoserver:latest
```
安装koishi版
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/ygoserver/config -v $PWD/expansions:/ygoserver/ygopro/expansions --name=ygoserver --restart=always yunikon525/ygoserver:koishi
```

## 参数说明
 * --ygo-web=[true|false]
   * `--ygo-web=true`开启简易控制台功能
   * 配合`--ygo-web-passwd=123456` 可将密码设置为：123456。
   * 控制台：http://(ip):7980
 * --ygo-windbot=[true|false]
   * 是否启用本地人机对战(windbot)服务
   * 需配合`--install-mono`安装mono
   * 如果你安装了[windbot容器](https://hub.docker.com/r/yunikon525/windbot)，则请勿使用此参数
 * --ygo-lflist=
   * `--ygo-lflist=0` 设置房间默认使用第1个禁卡表
 * --ygo-mode=
   * 0：单局，1：比赛，2：双打
   * `--ygo-mode=0` 设置房间默认为单局模式
 * --ygo-card-rule=
   * 0：OCG，1：TCG，2：简中，3：自定义，4：无独有卡，5：允许所有卡
   * `--ygo-card-rule=0` 设置房间默认只允许OCG
 * --ygo-duel-rule=
   * `--ygo-duel-rule=5` 设置默认使用大师规则2020
 * --ygo-lp=
   * `--ygo-lp=8000` 设置房间默认LP为8000
 * --ygo-time=
   * `--ygo-time=180` 设置房间默认每回合时间为180秒
 * --welcome=
   * `--welcome="欢迎来到我的服务器"` 设置服务器欢迎信息
 * --tips-url=
   * `--tips-url="http://127.0.0.1:7980/data/tip.json"` 设置服务器提示消息url
 * --dialogues-url=
   * `--tips-url="http://127.0.0.1:7980/data/dialogues.json"` 设置服务器召唤词url
 * --random-duel=[true|false]
   * `--random-duel=true` 开启随机决斗
 * --tournament=[true|false]
   * `--tournament=true` 开启竞赛模式
   * 可以配合 http://(ip):7980/deck-dashboard.html
 * --cloud-replay=[true|false]
   * `--cloud-replay=true` 开启云录像，需要安装MySQL，配合下列参数使用
     * `--mysql-host=127.0.0.1` MySQL服务器地址
     * `--mysql-port=3306` MySQL端口
     * `--mysql-user=root` MySQL用户名
     * `--mysql-passwd=123456` MySQL密码
     * `--mysql-db=ygopro` MySQL数据库
 * --windbot=[true|false]
   * `--windbot=true` 开启人机对战功能
   * 如果你使用[windbot容器](https://hub.docker.com/r/yunikon525/windbot)，请配合 `--windbot-ip=`与`--windbot-port=`使用

**使用示例** 开启web简易控制台，不开启人机功能，房间LP为16000，启用竞赛模式
```
docker run -d -p 7911:7911 -p 7922:7922 -v $PWD/config:/ygoserver/config -v $PWD/expansions:/ygoserver/ygopro/expansions --name=ygoserver --restart=always yunikon525/ygoserver --ygo-web=true --windbot=false --ygo-lp=16000 --tournament=true
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
