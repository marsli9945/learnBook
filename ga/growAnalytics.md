# <center>产品设计方案</center>

项目名称|项目编号|编写日期|编写人员
:-:|:--:|:--:|:--:
GrowAnalytics||2019-09-25|李磊

## 一、引言

### :paperclip:<font color=red>GA系统简介</font>

&emsp;&emsp;GA\(全称：grow analytics\)，是针对公司内部产品特色推出的深度用户行为分析产品，支持客户端、服务器、业务数据、第三方数据的全端采集和建模，驱动营销渠道效果评估、用户精细化运营改进、产品功能机用户体验优化、实时数据监控辅助管理决策，让用户行为发挥深远的价值

### :paperclip:<font color=red>业务痛点</font>
&emsp;&emsp;数据实时性：GA系统坚持‘实时化’的设计理念，运营指标实时监控，核心指标增加预警机制，提升决策效率。

&emsp;&emsp;用户运营不精确：“千人一面”的全量用户营销，投入产出难以把控，不精准的粗犷方式难以真正提升存量用户的长期活跃度。GA帮助项目锁定具有相似特征的用户群体，定向推送‘投其所好’的营销内容，提升不同用户群体的粘性。对长期未登录的用户群体，定向推送消息或活动召回。同时，GA建立用户标签体系和用户画像，将用户行为结合运营数据交叉分析，洞察核心用户特点，勾勒精准用户画像。

&emsp;&emsp;产品迭代数据量化问题：gdss41缺少实时的用户行为分析能力，使得产品功能改版的效果无法量化衡量，bug问题察觉滞后，造成用户流失。GA系统提供自助化漏斗分析模型，帮助项目组提升产品上的转化，对项目核心转化流程（如：启动、支付 等）进行监控，洞察流失问题。同时，GA系统提自定义留存分析，帮助企业提高用户留存，用数据验证最受用户欢迎的产品功能，提升产品竞争力。

&emsp;&emsp;营销分析断层：市场营销成本居高不下，投放拉新的效果追踪出现断层，无法追踪各渠道实际转化率，难以准确分析 ROI。GA系统提供渠道追踪功能，追踪新用户的渠道来源，用数据直观评估渠道拉新能力。同时，能分析注册转化和付费转化，端到端衡量渠道拉新质量，不断调整渠道影响策略。

### :paperclip:<font color=red>技术痛点</font>
&emsp;&emsp;日常配合效率低：项目组运营人员进行专题研究所需的数据，要向BI提需求，进入需求说明、需求评估、迭代排期、需求纠偏的循环。 GA系统可帮助运营人员快速上手使用产品，无需请求数据工程师的支持，即可通过GA系统的日日常数据看版查看日常重要数据指标；同时，通过GA系统的的自助分析模型可实现用户自定义指标查看、任意维度交叉分析，数据下钻和上卷、定位异常数据指标。

## 二、系统设计

### :paperclip:<font color=red>设计思想</font>

&emsp;&emsp;GrowAnalytices作为取代gdss41的新一代数据后台，除了实现原有gdss41的相关报表和数据展示功能外，更需要以灵活便捷的方式为用户提供数据查询和自动化分析能力，使用户可以根据自己的需求自助的获取相关数据完成整个数据分析留存。在前端UI美化升级的同时，赋予系统更加人性的交互方式和更加强大的系统组件为用户提供多种多样的数据获取方式。

**:guitar:效果对比**

<font color=peak>gdss41日常数据页面</font>
@import "gdss41日常数据.png"

<font color=#409eff>ga日常数据页面</font>
@import "ga日常数据.png"

**:rocket:ga除基本的数据展示页面外，还有多种丰富类型的页面**

<font color=#409eff>ga自助查询</font>
@import "ga自助查询.png"

<font color=#409eff>ga日志检索</font>
@import "ga日志检索.png"

### :paperclip:<font color=red>系统架构设计</font>

&emsp;&emsp;GrowAnalytics系统采用前后端分离的开发模式，主要由前端、中间层及后端微服务构成。其中前端及中间层部分由BM负责开发，可以完整的支撑整个系统的基本流程，BI负责开发后端接口只需面对业务逻辑即可。
    
类型|技术栈|功能
:--:|:--:|:--:
客户端|vue、element-ui|客户端页面展示
中间层|php、swoole|服务的渲染、websocket服务、用户及权限校验
服务端|spring-cloud、spring-boot|数据核心功能服务

#### 1、前端
&emsp;&emsp;前端使用vue框架以及配套的vuex和vue-router组件，实现前端路由跳转以及前端缓存等相关功能，接口请求使用axios组件，数据格式统一使用json格式。页面渲染搭配使用element-ui完成页面基础组件的实现，可以灵活美观的构建所需要的复杂页面需求。

#### 2、中间层
&emsp;&emsp;中间层主要负责进行服务端渲染，建立服务端和前端交互的桥梁，屏蔽了中间的复杂性和反复校验环节。利用php+swoole实现websocket长连接，为前后端的交互提供http以外的额外功能，实现页面交互的异步刷新和后端消息主动推送功能。

#### 3、服务端
&emsp;&emsp;spring-cloud实现的微服务集群，由后端开发者提供整个系统核心的服务部分，完成核心的数据服务部分。

@import "ga架构图.png"

### :paperclip:<font color=red>系统分析</font>
&emsp;&emsp;在GrowAnalytics中用户的整个请求过程涉及多层间的交互，加上bi数据处理中可能出现加载超时等问题，天然具备不同于普通web系统复杂性。因此在整个系统的实现中，引入websokcet处理常规http服务之外的需求，在部分细节处理中也做出特殊设计以满足交互需求。

#### 1、用户接口请求校验
&emsp;&emsp;用户登录状态通过jwt实现，在用户登录后将用户必要信息序列化后通过des3加密生成用户token返回给前端，在后续的每次接口请求中都必须携带该token通过用户校验才可以正常访问。  

jwt格式：
```
{
    userName: "admin", // 用户名
    permissions: [], // 用户权限
    expire: 15885466411 // 过期时间(毫秒时间戳)
}
```

#### 2、websocket的使用
&emsp;&emsp;用户正常登录后前端初始化socket连接，在用户登录状态超时前长连接始终保持连接状态，过程中一旦因为网络波动或其他不可抗力因素断开连接只需重连即可。长链持续中后端数据处理成功后可以通过调用中间层的接口实现对前端的主动推送功能。

## 三、编码规范

### :paperclip:<font color=red>前后端通信接口规范</font>

#### 1、接口格式

##### 1-1、基本格式

```
{
    "status": 200,
    "msg": "success",
    "data": {}
}
```

* status: 接口状态码

* msg: 接口返回消息

* data: 接口中提供的数据集合(可以是任意层的嵌套)

> ps:在操作返回的接口中由于没有需要回传的数据，所以在此类接口中data设为空即可

##### 1-2、数据列表获取接口

```
{
    "status": 200,
    "msg": "success",
    "data": {
        "content": [],
        "totalElements": 0
    }
}
```

* content: 数据记录结果，一般是结果数组  
* totalElements: 当前条件下总记录条数\(由于分页的原因一次只会在items中返回有限条数\)

> ps:由于前端分页组件普遍需要数据总条数，所以在data中一般将返回的数据列放入items中，total用于返回总记录条数

##### 1-3、操作结果返回接口

```
{
    "status": 404,
    "msg": "Not Found",
    "data": {}
}

{
    "status": 403,
    "msg": "权限不足"
}
```

> ps: 在此类接口中msg只用于显示报错信息，若有其他需要回传处理的数据都加入到data中即可

#### 2、接口状态码规范

| 状态码 | 类型 | 描述 |
| :---: | :---: | :---: |
| 2\*\* | success | 接口正常返回无错误 |
| 4\*\* | exception | 接口异常，提示信息反馈给用户 |
| 5\*\* | error | 系统错误，对用户屏蔽报错信息 |

> ps: 在日常使用中，若有特殊需求需自定义状态码时，应尽量避免与已有通用httpcode码冲突

### :paperclip:<font color=red>外部统计接口规范</font>

&emsp;&emsp;对外接口调用httpMethod主要涉及get、post、put、delete四种方式，其中get与delete为简单调用方式参数构建到URL中通过明文传递。post和put数据放入body中以json格式传递，http到头信息中会通过Content-typ:application/json;charset=utf-8进行标注。

### :paperclip:<font color=red>系统代码管理svn(git)</font>
&emsp;&emsp;系统开发过程中采用svn+git的方式进行代码版本管理，由于前端框架中会产生大量不需要加入版本管理的资源，相对于svn而言git只需要使用.gitignore文件即可便捷筛选管理。因此代码日常的变动管理使用公司内网的gitLab进行管理，上线时将打包好的项目通过svn上传部署到线上服务器即可。

**:hammer:gitFlow工作流图例**

@import "gitflow.png"

### :paperclip:<font color=red>项目部署</font>

#### <font color=green>前端</font>

&emsp;&emsp;使用nginx直接配置代理dist目录即可，通过indx.html入口即可进入系统。

#### <font color=green>后端</font>

&emsp;&emsp;将代码打包后产出的simple.phar拉取到线上，通过php simple.phar start 即可启动进程，此处使用supervisor进程管理工具进行托管防止应用进程意外挂起。其次通过nginx反向代理将后端监听端口转发到前端域名下，绕开浏览器同源策略问题实现接口同源化避免跨域问题。

## 四、功能模块设计

### :paperclip:<font color=red>用户登录及权限管理</font>

#### <font color=green>功能用途</font>

&emsp;&emsp;实现系统基本的登录和权限控制功能，在接入实际业务模块前可以流畅的概览整个系统基本框架结构。

#### <font color=green>数据库设计</font>

@import "grow_analytics.sql"

#### <font color=green>接口文档</font>

@import "system_api.md"

### :paperclip:<font color=red>数据服务配置</font>

#### <font color=green>功能用途</font>

&emsp;&emsp;为自助分析模块的检索选项增添和管理相关选项，提供下拉列表相关接口。

#### <font color=green>数据库设计</font>

@import "data_services_config.sql"

#### <font color=green>接口文档</font>

@import "data_services_config_api.md"


