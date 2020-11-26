
CREATE TABLE IF NOT EXISTS `user_info` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `passcode` char(12) NOT NULL DEFAULT '' COMMENT '加密随机数',
  `passwd` char(64) NOT NULL DEFAULT '' COMMENT 'md5密码',
  `status` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '用户账号状态。0-默认；1-冻结；2-停号',
  `hardware` varchar(64) NOT NULL DEFAULT '' COMMENT 'hardware',
  `ctime` timestamp NOT NULL DEFAULT '2013-03-15 14:38:09',
  `mtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '用户信息表';

CREATE TABLE IF NOT EXISTS `login_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` int unsigned NOT NULL DEFAULT 0 COMMENT '用户UID',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '登录状态，0登录，1登出',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  `ip` varchar(31) NOT NULL DEFAULT '' COMMENT 'ip',
  `hardware` varchar(64) NOT NULL DEFAULT '' COMMENT 'hardware',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '用户登录表';

CREATE TABLE IF NOT EXISTS `login_last` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `uid` int unsigned NOT NULL DEFAULT 0 COMMENT '用户UID',
   `login_time` timestamp COMMENT '登录时间',
   `logout_time` timestamp COMMENT '登出时间',
   `ip` varchar(31) NOT NULL DEFAULT '' COMMENT 'ip',
   `is_logout` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '是否logout,1:logout，0:login',
   `session` varchar(100) COMMENT '会话',
   `hardware` varchar(64) NOT NULL DEFAULT '' COMMENT 'hardware',
   UNIQUE KEY (`uid`),
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '最后一次用户登录表';

CREATE TABLE IF NOT EXISTS `role` (
   `rid` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'roleId',
   `uid` int unsigned NOT NULL COMMENT '用户UID',
   `sid` int unsigned NOT NULL COMMENT 'serverId',
   `headId` int unsigned NOT NULL DEFAULT 0 COMMENT '头像Id',
   `sex` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '性别，0:女 1男',
   `nick_name` varchar(100) COMMENT 'nick_name',
   `balance` int unsigned NOT NULL DEFAULT 0 COMMENT '余额',
   `login_time` timestamp COMMENT '登录时间',
   `logout_time` timestamp COMMENT '登出时间',
   `profile` varchar(500) COMMENT '个人简介',
   `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   UNIQUE KEY (`sid`,`uid`),
   PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '玩家表';

CREATE TABLE IF NOT EXISTS `map_role_city` (
   `cityId` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'cityId',
   `rid` int unsigned NOT NULL COMMENT 'roleId',
   `x` int unsigned NOT NULL COMMENT 'x坐标',
   `y` int unsigned NOT NULL COMMENT 'y坐标',
   `name` varchar(100) NOT NULL DEFAULT '城池' COMMENT '城池名称',
   `is_main` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '是否是主城',
   `level` tinyint unsigned NOT NULL DEFAULT 1 COMMENT 'level',
   `max_durable` int unsigned NOT NULL COMMENT '最大耐久',
   `cur_durable` int unsigned NOT NULL COMMENT '当前耐久',
   `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`cityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '玩家城池';

CREATE TABLE IF NOT EXISTS `national_map` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `mid` int unsigned NOT NULL,
   `x` int unsigned NOT NULL COMMENT 'x坐标',
   `y` int unsigned NOT NULL COMMENT 'y坐标',
   `type` int unsigned NOT NULL COMMENT '建筑类型',
   `level` tinyint unsigned NOT NULL DEFAULT 1 COMMENT 'level',
    UNIQUE KEY (`mid`),
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '全国地图';



CREATE TABLE IF NOT EXISTS `map_role_build` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `rid` int unsigned NOT NULL,
   `type` int unsigned NOT NULL COMMENT '建筑类型',
   `level` tinyint unsigned NOT NULL COMMENT '建筑等级',
   `x` int unsigned NOT NULL COMMENT 'x坐标',
   `y` int unsigned NOT NULL COMMENT 'y坐标',
   `name` varchar(100) NOT NULL COMMENT '名称',
   `wood` int unsigned NOT NULL COMMENT '木',
   `iron` int unsigned NOT NULL COMMENT '铁',
   `stone` int unsigned NOT NULL COMMENT '石头',
   `grain` int unsigned NOT NULL COMMENT '粮食',
   `max_durable` int unsigned NOT NULL COMMENT '最大耐久',
   `cur_durable` int unsigned NOT NULL COMMENT '当前耐久',
   `defender` int unsigned NOT NULL COMMENT '守军强度',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '角色建筑';

CREATE TABLE IF NOT EXISTS `city_facility` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `cityId` int unsigned NOT NULL COMMENT '城市id',
   `facilities` varchar(4096) NOT NULL COMMENT '设施列表，格式为json结构',
   UNIQUE KEY (`cityId`),
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '城池设施';

CREATE TABLE IF NOT EXISTS `role_res` (
   `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
   `rid` int unsigned NOT NULL COMMENT "rid",
   `wood` int unsigned NOT NULL COMMENT '木',
   `iron` int unsigned NOT NULL COMMENT '铁',
   `stone` int unsigned NOT NULL COMMENT '石头',
   `grain` int unsigned NOT NULL COMMENT '粮食',
   `gold` int unsigned NOT NULL COMMENT '金币',
   `decree` int unsigned NOT NULL COMMENT '令牌',
   `depot_capacity` int unsigned NOT NULL COMMENT '仓库容量',
   
   `wood_yield` int unsigned NOT NULL COMMENT '木产量',
   `iron_yield` int unsigned NOT NULL COMMENT '铁产量',
   `stone_yield` int unsigned NOT NULL COMMENT '石头产量',
   `grain_yield` int unsigned NOT NULL COMMENT '粮食产量',
   `gold_yield` int unsigned NOT NULL COMMENT '金币产量',

   UNIQUE KEY (`rid`),
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '角色资源表';

CREATE TABLE IF NOT EXISTS `general` (
   `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
   `rid` int unsigned NOT NULL COMMENT "rid",
   `name` varchar(100) NOT NULL COMMENT "名字",
   `cfgId` int unsigned NOT NULL COMMENT "配置id",
   `force` int unsigned NOT NULL COMMENT '武力',
   `strategy` int unsigned NOT NULL COMMENT '策略',
   `defense` int unsigned NOT NULL COMMENT '防御',
   `speed` int unsigned NOT NULL COMMENT '速度',
   `destroy` int unsigned NOT NULL COMMENT '破坏',
   `force_grow` int unsigned NOT NULL COMMENT '武力成长',
   `strategy_grow` int unsigned NOT NULL COMMENT '策略成长',
   `defense_grow` int unsigned NOT NULL COMMENT '防御成长',
   `speed_grow` int unsigned NOT NULL COMMENT '速度成长',
   `destroy_grow` int unsigned NOT NULL COMMENT '破坏成长',
   `physical_power` int unsigned NOT NULL COMMENT '体力',
   `cost` int unsigned NOT NULL COMMENT 'cost',
   `exp` int unsigned NOT NULL COMMENT '经验',
   `order` tinyint NOT NULL COMMENT '第几队',
   `level` tinyint unsigned NOT NULL DEFAULT 1 COMMENT 'level',
   `cityId` int NOT NULL DEFAULT 0 COMMENT '城市id',
   `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '将领表';

CREATE TABLE IF NOT EXISTS `army` (
   `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
   `rid` int unsigned NOT NULL COMMENT "rid",
   `cityId` int unsigned NOT NULL COMMENT '城市id',
   `order` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '第几队 1-5队',
   `generals` varchar(256) NOT NULL DEFAULT '[0, 0, 0]' COMMENT "将领",
   `soldiers` varchar(256) NOT NULL DEFAULT '[0, 0, 0]' COMMENT "士兵",
   `cmd` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '命令  0:空闲 1:攻击 2：驻军 3:返回',
   `from_x` int unsigned NOT NULL COMMENT '来自x坐标',
   `from_y` int unsigned NOT NULL COMMENT '来自y坐标',
   `to_x` int unsigned COMMENT '去往x坐标',
   `to_y` int unsigned COMMENT '去往y坐标',
   `start` timestamp COMMENT '出发时间',
   `end` timestamp COMMENT '到达时间',
   UNIQUE KEY (`rid`, `cityId`, `order`),
   PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '军队表';

CREATE TABLE IF NOT EXISTS `war_report` (
   `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
   `attack_rid` int unsigned NOT NULL COMMENT "攻击方id",
   `defense_rid` int unsigned NOT NULL DEFAULT 0 COMMENT "防守方id,0为系统npc",
   `beg_attack_army` varchar(512) NOT NULL COMMENT '开始攻击方军队',
   `beg_defense_army` varchar(512) NOT NULL COMMENT '开始防守方军队',
   `end_attack_army` varchar(512) NOT NULL COMMENT '开始攻击方军队',
   `end_defense_army` varchar(512) NOT NULL COMMENT '开始防守方军队',
   `attack_general` varchar(1024) NOT NULL COMMENT '攻击方武将',
   `defense_general` varchar(1024) NOT NULL COMMENT '防守方武将',
   `attack_is_win` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '是否攻击方胜利 0:否 1:是',
   `attack_is_read` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '攻击方战报是否已阅 0:未阅 1:已阅',
   `defense_is_read` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '攻击方战报是否已阅 0:未阅 1:已阅',
   `destroy_durable` int unsigned COMMENT '破坏了多少耐久',
   `occupy` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '是否攻占 0:否 1:是',
   `x` int unsigned COMMENT 'x坐标',
   `y` int unsigned COMMENT 'y坐标',
   `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '战报表';

