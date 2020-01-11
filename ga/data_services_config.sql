/*
 Navicat Premium Data Transfer

 Source Server         : 开发测试
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 192.168.10.143
 Source Database       : data_services_config

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : utf-8

 Date: 10/28/2019 16:24:08 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `28-device_property`
-- ----------------------------
DROP TABLE IF EXISTS `28-device_property`;
CREATE TABLE `28-device_property` (
  `name` varchar(50) NOT NULL COMMENT '属性名',
  `show_name` varchar(100) DEFAULT NULL COMMENT '显示名',
  `data_type` varchar(50) DEFAULT NULL COMMENT '数据类型',
  `format` varchar(50) DEFAULT NULL COMMENT '单位/格式',
  `dictionaries` varchar(100) DEFAULT NULL COMMENT '字典',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '显示状态',
  `remark` text COMMENT '备注',
  `preset` tinyint(1) unsigned DEFAULT '1' COMMENT '预置',
  `position` varchar(100) DEFAULT NULL COMMENT '字段位置',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `28-event`
-- ----------------------------
DROP TABLE IF EXISTS `28-event`;
CREATE TABLE `28-event` (
  `name` varchar(50) NOT NULL COMMENT '事件名',
  `show_name` varchar(50) DEFAULT NULL COMMENT '显示名',
  `label` varchar(50) DEFAULT NULL COMMENT '标签',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '显示状态',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `28-event_property`
-- ----------------------------
DROP TABLE IF EXISTS `28-event_property`;
CREATE TABLE `28-event_property` (
  `name` varchar(50) NOT NULL COMMENT '属性名',
  `show_name` varchar(100) DEFAULT NULL COMMENT '显示名',
  `data_type` varchar(50) DEFAULT NULL COMMENT '数据类型',
  `format` varchar(50) DEFAULT NULL COMMENT '单位/格式',
  `dictionaries` varchar(100) DEFAULT NULL COMMENT '字典',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '显示状态',
  `remark` text COMMENT '备注',
  `preset` tinyint(1) unsigned DEFAULT '1' COMMENT '预置',
  `position` varchar(100) DEFAULT NULL COMMENT '字段位置',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `28-event_property_map`
-- ----------------------------
DROP TABLE IF EXISTS `28-event_property_map`;
CREATE TABLE `28-event_property_map` (
  `event_name` varchar(100) NOT NULL COMMENT '事件名称',
  `property_name` varchar(100) NOT NULL COMMENT '属性名',
  PRIMARY KEY (`event_name`,`property_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `28-user_property`
-- ----------------------------
DROP TABLE IF EXISTS `28-user_property`;
CREATE TABLE `28-user_property` (
  `name` varchar(50) NOT NULL COMMENT '属性名',
  `show_name` varchar(100) DEFAULT NULL COMMENT '显示名',
  `data_type` varchar(50) DEFAULT NULL COMMENT '数据类型',
  `format` varchar(50) DEFAULT NULL COMMENT '单位/格式',
  `dictionaries` varchar(100) DEFAULT NULL COMMENT '字典',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '显示状态',
  `remark` text COMMENT '备注',
  `preset` tinyint(1) unsigned DEFAULT '1' COMMENT '预置',
  `position` varchar(100) DEFAULT NULL COMMENT '字段位置',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `28-virtual_event`
-- ----------------------------
DROP TABLE IF EXISTS `28-virtual_event`;
CREATE TABLE `28-virtual_event` (
  `name` varchar(50) NOT NULL COMMENT '事件名',
  `show_name` varchar(50) DEFAULT NULL COMMENT '显示名',
  `label` varchar(50) DEFAULT NULL COMMENT '标签',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '显示状态',
  `remark` text COMMENT '备注',
  `event_list` json DEFAULT NULL COMMENT '包含事件',
  `value` json DEFAULT NULL COMMENT '虚拟事件json片段',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
