# <center>Ads广告数据统计系统</center>
项目名称|项目编号|编写日期|编写人员
:-:|:--:|:--:|:--:
广告数据统计系统||2020-03-02|李磊

### :paperclip:<font color=red>名称解释和前置规则</font>
#### 后端功能额外提供人员
- 刘锁
- 许国超
#### 固有维度区分：
- 游戏：cloud_id、platform_id、product_id
- 工作室：group_name
- 版本：sub_platform_id
- 广告渠道：promote_channel
- UA师：ua_admin
#### 数据表头和数据库中字段对应关系
数据在数据表中的value字段，格式为json
```
public static $columnMap = [
    '消耗' => 'consume',
    '实际消耗' => 'consume_actual',
    '新增' => 'new_user',
    'CPA' => 'cpa',
    '广告收入' => 'income',
    '付费金额' => 'pay_amount',
    'ROI' => 'roi',
    '注册且付费人数' => 'reg_pay_num',
    '注册且付费金额' => 'reg_pay_amount',
    '首日ROI' => 'first_roi',
    '七日ROI' => 'seven_roi',
    '2日留存' => '2remain',
    '3日留存' => '3remain',
    '4日留存' => '4remain',
    '5日留存' => '5remain',
    '6日留存' => '6remain',
    '7日留存' => '7remain',
    '15日留存' => '15remain',
    '30日留存' => '30remain',
    '2日LTV' => '2LTV',
    '3日LTV' => '3LTV',
    '4日LTV' => '4LTV',
    '5日LTV' => '5LTV',
    '6日LTV' => '6LTV',
    '7日LTV' => '7LTV',
    '15日LTV' => '15LTV',
    '30日LTV' => '30LTV',
];
```
#### 额外计算规则
- consume:保留两位小数
- consume_actual:保留两位小数

### :paperclip:<font color=red>模块说明</font>
#### :book:ads归因
#### &emsp;&emsp;:hammer:媒体投放数据
##### 涉及数据表
- ads_market_data
```
CREATE TABLE `ads_market_data` (
  `day` date NOT NULL DEFAULT '1000-01-01' COMMENT '日期',
  `cloud_id` int(10) NOT NULL DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) NOT NULL DEFAULT '-2' COMMENT '平台ID',
  `product_id` int(10) NOT NULL DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) NOT NULL DEFAULT '-1' COMMENT '工作室',
  `promote_channel` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告渠道',
  `activity_name` varchar(30) NOT NULL DEFAULT '-1' COMMENT '活动参数',
  `sub_platform_id` varchar(30) NOT NULL DEFAULT '-2' COMMENT '手机型号',
  `value` json DEFAULT NULL,
  PRIMARY KEY (`day`,`cloud_id`,`platform_id`,`product_id`,`sub_platform_id`,`promote_channel`,`group_name`,`activity_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM
```
- ads_client_config
```
CREATE TABLE `ads_client_config` (
  `id` int(30) unsigned NOT NULL AUTO_INCREMENT,
  `cloud_id` int(10) NOT NULL DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) NOT NULL DEFAULT '-1' COMMENT '平台ID',
  `product_id` int(10) NOT NULL DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) NOT NULL DEFAULT '-1' COMMENT '工作室',
  `promote_channel` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告渠道',
  `sub_platform_id` varchar(50) NOT NULL DEFAULT 'Android',
  `activity_name` varchar(150) NOT NULL,
  `ua_admin` varchar(100) DEFAULT NULL,
  `channel_id` varchar(30) DEFAULT NULL,
  `product_nickname` varchar(30) DEFAULT NULL,
  `client_id` text,
  `update_admin` varchar(100) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM'
```

##### 最终展示结果和计算逻辑
&emsp;&emsp;说明：数据来源是ads_market_data表，但最终显示但维度中<font color=red>UA师(ua_admin)</font>并没有现成的，数据表中提供的而是<font color=red>活动参数(activity_name)</font>，因此需要通过客户端配置表ads_client_config提供的映射关系将<font color=red>活动参数</font>转化为<font color=red>UA师</font>，对应关系为一对多。

#### &emsp;&emsp;:hammer:工作室数据汇总

##### 最终展示结果和计算逻辑
&emsp;&emsp;说明：数据来源和计算方式与媒体投放数据页面基本一致，只是将广告渠道维度进行汇总。

#### &emsp;&emsp;:hammer:客户端配置
##### 涉及数据表
- ads_client_config
```
CREATE TABLE `ads_client_config` (
  `id` int(30) unsigned NOT NULL AUTO_INCREMENT,
  `cloud_id` int(10) NOT NULL DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) NOT NULL DEFAULT '-1' COMMENT '平台ID',
  `product_id` int(10) NOT NULL DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) NOT NULL DEFAULT '-1' COMMENT '工作室',
  `promote_channel` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告渠道',
  `sub_platform_id` varchar(50) NOT NULL DEFAULT 'Android',
  `activity_name` varchar(150) NOT NULL,
  `ua_admin` varchar(100) DEFAULT NULL,
  `channel_id` varchar(30) DEFAULT NULL,
  `product_nickname` varchar(30) DEFAULT NULL,
  `client_id` text,
  `update_admin` varchar(100) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM'
```

##### 最终展示结果和计算逻辑
&emsp;&emsp;典型的配置模块，对相应的配置表增删改查操作，额外提供excel上传模式，对于后端来说只是需要额外提供批量导入的接口。

#### &emsp;&emsp;:hammer:监测链接生成
##### 最终展示结果和计算逻辑
&emsp;&emsp;对前端只是基础的表单编辑功能，后端接口由<font color=blue>刘锁</font>提供，直接调用即可。


#### :book:AppsFlyer归因
#### &emsp;&emsp;:hammer:媒体投放数据
##### 涉及数据表

- af_campaign_data
```
CREATE TABLE `af_campaign_data` (
  `day` date NOT NULL DEFAULT '1000-01-01' COMMENT '日期',
  `cloud_id` int(10) NOT NULL DEFAULT '-1' COMMENT 'CLOUDID',
  `product_id` int(10) NOT NULL DEFAULT '-1' COMMENT '产品ID',
  `sub_platform_id` varchar(30) NOT NULL DEFAULT '-2' COMMENT 'ios or android',
  `promote_channel` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告渠道',
  `campaign_id` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告ID',
  `value` json DEFAULT NULL,
  PRIMARY KEY (`day`,`cloud_id`,`product_id`,`promote_channel`,`campaign_id`,`sub_platform_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='AF-ALL-CAMPAIGN'
```

- af_campaign
```
CREATE TABLE `af_campaign` (
  `id` int(50) unsigned NOT NULL AUTO_INCREMENT,
  `cloud_id` int(10) DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) DEFAULT '-1' COMMENT '平台ID',
  `product_id` int(10) DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) DEFAULT '-1' COMMENT '工作室',
  `promote_channel` varchar(30) DEFAULT '-1' COMMENT '广告渠道',
  `sub_platform_id` varchar(30) DEFAULT '-1' COMMENT '手机型号',
  `campaign` varchar(30) DEFAULT NULL,
  `ua_admin` varchar(50) DEFAULT NULL,
  `account` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `update_admin` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM'
```

##### 最终展示结果和计算逻辑
&emsp;&emsp;说明：数据来源是af_campaign_data表，但最终显示但维度中<font color=red>UA师(ua_admin)</font>并没有现成的，数据表中提供的而是<font color=red>广告系列(campaign_id)</font>，因此需要通过客户端配置表af_campaign提供的映射关系将<font color=red>广告系列 </font>转化为<font color=red>UA师</font>，对应关系为一对多。

#### &emsp;&emsp;:hammer:工作室数据汇总

##### 最终展示结果和计算逻辑
&emsp;&emsp;说明：数据来源和计算方式与媒体投放数据页面基本一致，只是将广告渠道维度进行汇总。

#### &emsp;&emsp;:hammer:广告系列配置
##### 涉及数据表
- af_campaign
```
CREATE TABLE `af_campaign` (
  `id` int(50) unsigned NOT NULL AUTO_INCREMENT,
  `cloud_id` int(10) DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) DEFAULT '-1' COMMENT '平台ID',
  `product_id` int(10) DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) DEFAULT '-1' COMMENT '工作室',
  `promote_channel` varchar(30) DEFAULT '-1' COMMENT '广告渠道',
  `sub_platform_id` varchar(30) DEFAULT '-1' COMMENT '手机型号',
  `campaign` varchar(30) DEFAULT NULL,
  `ua_admin` varchar(50) DEFAULT NULL,
  `account` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `update_admin` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM'
```

##### 最终展示结果和计算逻辑
&emsp;&emsp;典型的配置模块，对相应的配置表增删改查操作，额外提供excel上传模式，对于后端来说只是需要额外提供批量导入的接口。

#### :book:通用配置
#### &emsp;&emsp;:hammer:账户消耗配置
##### 涉及数据表
- ads_consume
```
CREATE TABLE `ads_consume` (
  `id` int(30) unsigned NOT NULL AUTO_INCREMENT,
  `day` date NOT NULL DEFAULT '1000-01-01' COMMENT '日期',
  `cloud_id` int(10) NOT NULL DEFAULT '-1' COMMENT 'CLOUDID',
  `platform_id` int(10) NOT NULL DEFAULT '-1' COMMENT '平台ID',
  `product_id` int(10) NOT NULL DEFAULT '-1' COMMENT '产品ID',
  `group_name` varchar(30) NOT NULL DEFAULT '-1' COMMENT '工作室',
  `sub_platform_id` varchar(30) NOT NULL DEFAULT '-1' COMMENT '手机型号',
  `promote_channel` varchar(30) NOT NULL DEFAULT '-1' COMMENT '广告渠道',
  `ua_admin` varchar(50) NOT NULL,
  `account` varchar(100) NOT NULL DEFAULT 'account' COMMENT '账号',
  `consume` varchar(30) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ADS-MARKET-SYSTEM' COMMENT='ADS-MARKET-SYSTEM'
```

##### 最终展示结果和计算逻辑
&emsp;&emsp;典型的配置模块，对相应的配置表增删改查操作，额外提供excel上传模式，对于后端来说只是需要额外提供批量导入的接口。

#### &emsp;&emsp;:hammer:账户返点比配置
##### 最终展示结果和计算逻辑
&emsp;&emsp;逻辑与其他配置页面一致，但所有操作均通过调用<font color=blue>许国超</font>的接口实现。

#### &emsp;&emsp;:hammer:消耗数据核对
##### 最终展示结果和计算逻辑
&emsp;&emsp;将账户消耗配置与爬虫爬取的数据按账户进行对比展示。
