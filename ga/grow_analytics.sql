/*
 Navicat Premium Data Transfer

 Source Server         : 开发测试
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 192.168.10.143
 Source Database       : grow_analytics

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : utf-8

 Date: 10/28/2019 16:24:23 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `system_game`
-- ----------------------------
DROP TABLE IF EXISTS `system_game`;
CREATE TABLE `system_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '默认游戏' COMMENT '游戏名称',
  `icon` text CHARACTER SET utf8 COMMENT '游戏图标',
  `platform_id` int(10) unsigned DEFAULT '1' COMMENT '应用类型 1移动端 3微信',
  `app_id` int(10) unsigned DEFAULT '1' COMMENT '应用编码',
  `time_zone` varchar(50) DEFAULT '+8' COMMENT '游戏数据统计的时区',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `updater` varchar(100) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '修改人',
  `update_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '修改时间',
  `creater` varchar(255) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index` (`name`,`platform_id`,`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='游戏列表';

-- ----------------------------
--  Table structure for `system_invitation`
-- ----------------------------
DROP TABLE IF EXISTS `system_invitation`;
CREATE TABLE `system_invitation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT 'name' COMMENT '姓名',
  `user_name` varchar(100) CHARACTER SET utf8 DEFAULT 'ga@tuyoogame.com' COMMENT '用户账号(邮箱)',
  `level` int(10) unsigned DEFAULT '100' COMMENT '用户角色等级',
  `permission` json DEFAULT NULL COMMENT '分配的权限树',
  `url` text CHARACTER SET utf8 COMMENT '邀请链接',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '状态 0未接受 1已发送 2已接受',
  `creater` varchar(50) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `system_map`
-- ----------------------------
DROP TABLE IF EXISTS `system_map`;
CREATE TABLE `system_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 DEFAULT '测试字典' COMMENT '权限名称',
  `ext` varchar(100) DEFAULT 'permission' COMMENT '字典编码(唯一标识)',
  `type` varchar(50) DEFAULT 'admin' COMMENT '字典类型',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `updater` varchar(50) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '修改人',
  `update_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '修改时间',
  `creater` varchar(255) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index` (`name`,`ext`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COMMENT='系统关键字映射字典';

-- ----------------------------
--  Table structure for `system_permission`
-- ----------------------------
DROP TABLE IF EXISTS `system_permission`;
CREATE TABLE `system_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 DEFAULT '默认权限' COMMENT '权限名称',
  `ext` varchar(100) DEFAULT 'permission' COMMENT '权限编码(唯一标识)',
  `type` varchar(50) DEFAULT 'admin' COMMENT '权限类型',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `updater` varchar(50) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '修改人',
  `update_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '修改时间',
  `creater` varchar(255) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index` (`name`,`ext`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='权限列表';

-- ----------------------------
--  Table structure for `system_studio`
-- ----------------------------
DROP TABLE IF EXISTS `system_studio`;
CREATE TABLE `system_studio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(100) CHARACTER SET utf8 DEFAULT 'studio' COMMENT '工作室名称',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `updater` varchar(100) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '修改人',
  `update_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '修改时间',
  `creater` varchar(100) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='工作室表';

-- ----------------------------
--  Table structure for `system_studio_game`
-- ----------------------------
DROP TABLE IF EXISTS `system_studio_game`;
CREATE TABLE `system_studio_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `studio_id` int(10) unsigned DEFAULT '1' COMMENT '工作室id',
  `game_id` int(10) unsigned DEFAULT '1' COMMENT '游戏id',
  PRIMARY KEY (`id`),
  KEY `index` (`game_id`,`studio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='工作室与管理员关系映射表——便于反向检索';

-- ----------------------------
--  Table structure for `system_user`
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `user_name` varchar(100) NOT NULL DEFAULT 'admin' COMMENT '用户登录账号',
  `password` char(32) DEFAULT '123456' COMMENT '密码',
  `name` varchar(100) CHARACTER SET utf8 DEFAULT '管理员' COMMENT '用户名称',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0关闭 1开启',
  `level` tinyint(10) unsigned DEFAULT '100' COMMENT '用户角色等级 0BI管理员 10项目运营 20测试 30数据营销 40商务 100无角色',
  `is_admin` tinyint(1) unsigned DEFAULT '0' COMMENT '是否是bi管理员',
  `updater` varchar(100) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '修改人',
  `update_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '修改时间',
  `creater` varchar(100) CHARACTER SET utf8 DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`user_name`),
  KEY `unio` (`user_name`,`password`,`level`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
--  Table structure for `system_user_permission`
-- ----------------------------
DROP TABLE IF EXISTS `system_user_permission`;
CREATE TABLE `system_user_permission` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT 'admin@tuyoogame.com' COMMENT '账号',
  `studio_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '工作室id',
  `distribute_name` varchar(100) CHARACTER SET utf8 DEFAULT 'admin@tuyoogame.com' COMMENT '分配人账号',
  `permission` json DEFAULT NULL COMMENT '权限列表',
  `game` json DEFAULT NULL COMMENT '游戏列表',
  `is_auto` tinyint(1) unsigned DEFAULT '0' COMMENT '是否自动填充工作室新权限',
  `is_distribute` tinyint(1) unsigned DEFAULT '0' COMMENT '是否可进行分配',
  `is_access_game` tinyint(1) DEFAULT '0' COMMENT '是否可以接入游戏',
  `is_admin` tinyint(1) unsigned DEFAULT '0' COMMENT '是否是工作室管理员',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '权限激活状态 0未激活 1已激活',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户持有权限列表--包含授权持有字段可进行工作室管理员和游戏接入人反向查询';

SET FOREIGN_KEY_CHECKS = 1;
