// ============================================================
// YGO 用户登录插件
// ============================================================

const initSqlJs = require("sql.js");
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");

const DB_PATH = path.resolve(process.cwd(), "config", "ygo_user.db");

// ---- 数据库 ----
let db = null;
let dbReady = false;

// ---- 数据库初始化 ----
async function initDB() {
  try {
    const SQL = await initSqlJs();
    let fileBuffer = null;
    try {
      fileBuffer = fs.readFileSync(DB_PATH);
    } catch (e) {
      // 数据库文件不存在，将新建
    }

    if (fileBuffer) {
      db = new SQL.Database(fileBuffer);
    } else {
      db = new SQL.Database();
    }

    // 建表
    db.run(`
      CREATE TABLE IF NOT EXISTS ygo_user (
        name          TEXT PRIMARY KEY,
        password_hash TEXT NOT NULL DEFAULT '',
        last_ip       TEXT NOT NULL DEFAULT ''
      )
    `);

    saveDB();
    dbReady = true;
    log.info("YGO-Login: 数据库初始化完成");
  } catch (e) {
    log.warn("YGO-Login: 数据库初始化失败", e);
  }
}

function saveDB() {
  if (!db) return;
  try {
    const data = db.export();
    const buffer = Buffer.from(data);
    // 确保config目录存在
    const configDir = path.dirname(DB_PATH);
    if (!fs.existsSync(configDir)) {
      fs.mkdirSync(configDir, { recursive: true });
    }
    fs.writeFileSync(DB_PATH, buffer);
  } catch (e) {
    log.warn("YGO-Login: 数据库保存失败", e);
  }
}

// 定时保存
setInterval(saveDB, 60000);

// ---- 用户操作 ----
function getUser(name) {
  const result = db.exec("SELECT * FROM ygo_user WHERE name=?", [name]);
  if (result.length === 0 || result[0].values.length === 0) return null;
  const cols = result[0].columns;
  const vals = result[0].values[0];
  const user = {};
  for (let i = 0; i < cols.length; i++) {
    user[cols[i]] = vals[i];
  }
  return user;
}

function createUser(name, ip, passwordHash) {
  db.run(
    `INSERT INTO ygo_user (name, password_hash, last_ip) VALUES (?, ?, ?)`,
    [name, passwordHash, ip]
  );
  saveDB();
  return getUser(name);
}

function updateUserIP(name, ip) {
  db.run("UPDATE ygo_user SET last_ip=? WHERE name=?", [ip, name]);
}

function md5Hash(text) {
  return crypto.createHash("md5").update(text).digest("hex");
}

// ---- 登录状态追踪（内存中） ----
// key: client引用标识, value: 用户名
const loggedInClients = new WeakMap();

function isLoggedIn(client) {
  return loggedInClients.has(client);
}

function getLoggedInName(client) {
  return loggedInClients.get(client);
}

function setLoggedIn(client, name) {
  loggedInClients.set(client, name);
}

// ---- 启动数据库 ----
initDB();

// ============================================================
// 钩子：检测玩家准备状态（HS_PLAYER_CHANGE）
// 当未注册或未登录的玩家变为准备状态时，踢出房间。
// 注：CTOS HS_READY 被直接透传到 ygopro 核心，srvpro 无法拦截；
//     CTOS UPDATE_DECK 拦截在 no_check_deck 时无效（核心不要求卡组）；
//     因此改为监听 STOC HS_PLAYER_CHANGE，在玩家成功准备后踢出。
// ============================================================
ygopro.stoc_follow_before(
  "HS_PLAYER_CHANGE",
  true,
  async function (buffer, info, client, server, datas) {
    const room = ROOM_all[client.rid];
    if (!room || !dbReady) return;

    const pos = info.status >> 4;
    const state = info.status & 0xf;
    if (state !== 9) return; // 9 = READY

    // 只处理自己的准备事件（HS_PLAYER_CHANGE 会广播给所有人）
    if (client.pos !== pos) return;
    if (client.is_local) return;

    const name = client.name;
    const user = getUser(name);

    if (!user) {
      ygopro.stoc_send_chat(
        client,
        "【YGO-USER】用户不存在，请先使用 /reg 密码 注册账号后再准备。已断开连接",
        ygopro.constants.COLORS.RED
      );
      CLIENT_kick(client);
      return;
    }

    if (isLoggedIn(client)) {
      return;
    }

    // 已注册，检查IP
    if (user.last_ip === client.ip) {
      setLoggedIn(client, name);
      updateUserIP(name, client.ip);
      return;
    }

    // IP不匹配
    ygopro.stoc_send_chat(
      client,
      "【YGO-USER】检测到IP变更，请使用 /login 密码 登录后再准备。已断开连接",
      ygopro.constants.COLORS.RED
    );
    CLIENT_kick(client);
  }
);

// ============================================================
// 钩子：聊天命令
// /reg, /login
// ============================================================
ygopro.ctos_follow_before(
  "CHAT",
  true,
  async function (buffer, info, client, server, datas) {
    const room = ROOM_all[client.rid];
    if (!room || !dbReady) return;

    const msg = _.trim(info.msg);

    // ---- /reg 密码 ----
    if (msg.substring(0, 4) === "/reg") {
      const password = _.trim(msg.substring(4));
      if (password.length < 1) {
        ygopro.stoc_send_chat(
          client,
          "【YGO-USER】请以 /reg 密码 的格式注册",
          ygopro.constants.COLORS.YELLOW
        );
        return true;
      }

      const name = client.name;
      const existing = getUser(name);
      if (existing) {
        ygopro.stoc_send_chat(
          client,
          "【YGO-USER】用户名 " + name + " 已被注册。如果是你的账号，请用 /login 密码 登录。如果忘记密码，请联系管理员",
          ygopro.constants.COLORS.RED
        );
        return true;
      }

      const hash = md5Hash(password);
      createUser(name, client.ip, hash);
      setLoggedIn(client, name);
      ygopro.stoc_send_chat(
        client,
        "【YGO-USER】注册成功！你现在可以准备了",
        ygopro.constants.COLORS.BABYBLUE
      );
      return true;
    }

    // ---- /login 密码 ----
    if (msg.substring(0, 6) === "/login") {
      const password = _.trim(msg.substring(6));
      if (password.length < 1) {
        ygopro.stoc_send_chat(
          client,
          "【YGO-USER】请以 /login 密码 的格式登录",
          ygopro.constants.COLORS.YELLOW
        );
        return true;
      }

      const name = client.name;
      const user = getUser(name);
      if (!user) {
        ygopro.stoc_send_chat(
          client,
          "【YGO-USER】用户不存在，请先用 /reg 密码 注册",
          ygopro.constants.COLORS.RED
        );
        return true;
      }

      const hash = md5Hash(password);
      if (user.password_hash !== hash) {
        ygopro.stoc_send_chat(
          client,
          "【YGO-USER】密码错误！",
          ygopro.constants.COLORS.RED
        );
        return true;
      }

      setLoggedIn(client, name);
      updateUserIP(name, client.ip);
      saveDB();
      ygopro.stoc_send_chat(
        client,
        "【YGO-USER】登录成功！",
        ygopro.constants.COLORS.BABYBLUE
      );
      return true;
    }

    // 非YGO命令，放行
    return;
  }
);