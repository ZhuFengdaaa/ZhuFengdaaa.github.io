---
layout: post
title: 2015-03-23 SegmentFault 技术沙龙
tag: conference
---
出发得晚了点，地铁没有我们预想的那么快 ╮(╯▽╰)╭ 。事先没做好功课，没料到中关村的车库咖啡在如此偏僻的一角，以致熟门熟路的出租车司机都绕了一大圈。

![车库咖啡](/assets/images/2015-03-25/cafe.jpg)

外面看如此不起眼，进去以后还是挺热闹的，走廊两边贴满了各大互联网公司的宣传单。终于找对了！

![现场](/assets/images/2015-03-25/now.jpg)

刘洋已经到了，坐在中间靠前的位置。台上是第一位嘉宾——帅哥陈本锋，云适配创始人。看来我们没错过多少。

##组件化 —— Web 前端开发的未来趋势
陈本锋讲的是Web前端的一次技术革新——Web组件化。以轮播图组件的引用方式为引入，介绍了webcomponent.js，Google和W3C联手推出的一系列标准。我们可以用它打包一系列组件。整一套标准有4个组成部分，他们可以一起或者分别被使用：

* Custom Elements
* Shadow DOM
* HTML Imports
* HTML Templates

####HTML5<template\>标签
我们目前使用的“组件化”解决方案是使用HTML5<template\>标签。

`<template>`元素特点:

* 内容被解析，但是不显示
* 图片资源不会被下载
* 脚本资源不会被下载或者执行

...直到它被使用

打包<template\>

{% highlight html %}

<script id="indexTemplate" type="text/template">
<h1>Inside a template </h1>
<img src="/image/xyz.png"/>
</script>

{% endhighlight %}

使用<template\>元素

{% highlight html %}

<template id="indexTemplate”>
<h1>Inside a template</h1>
<img src="/image/xyz.png"/>
</template>
var template = document.getElementById('indexTemplate');
holder.appendChild(template.content.cloneNode(true));

{% endhighlight %}

####WebComponents 的优点
webcomponent的自定义元素(Custom Element)与其相比。有这么几个优点：

* 有自己的一套规范。
* 有明显的层次概念，shadow DOM不受当前文档样式的影响。
* 调用方式简洁。
* 灵活，定义template和使用template的文件可以分离(HTML Import)。

*Talk is cheap, show me the* **code**

![showcode](/assets/images/2015-03-25/showcode.jpg)

最后帅哥陈本锋小小地打了下广告：Amaze UI（妹子UI). Github上有开源代码。我去点了个star。不过没用过，以后再画网页就记得用一下。

##大规模、高并发实时聊天平台的挑战和思路
然后是LeanCloud CTO 丰俊文分享的他们的一套实时通信服务。初创开发者可以把他们的后台服务打包到自己的产品中，然后只要专注于前端和运营即可。实时通信可以用于：聊天，私信，弹幕。抽奖，互动游戏，协同编辑等等。把后端托管给他们，他们帮我们解决高并发，实时，扩展性，安全性以及各个环节的定制。

后端。。不懂。。这里没怎么听。。总之就是，“我们非常可靠，技术非常牛，快来用我们的产品吧”。但是去官网 https://leancloud.cn/ 上看了下，价格真心便宜。Mark，以后有什么项目就考虑一下。（前提是没涨价）

![leancode](/assets/images/2015-03-25/leancode.png)

##HTML5 极速游戏开发——Egret

看了下Egret的界面，感觉非常棒。一套工具也就几十MB,功能非常全。以后开发HTML5游戏的首选。张鑫磊老师讲的也很不错，要点：

* 位置、拉伸、旋转、斜切四种操作的矩阵运算。
* 矢量图的优势（放大不失真），缺点（性能高）
* 圆角矩形的位图拉伸（九宫格解决方案）。
* 渲染机制。显示、隐藏、嵌套，显示列表解决方案。
* 脏矩形渲染优化。

![egret](/assets/images/2015-03-25/egret.png)

##怎样打造 1.5 亿 PV 的 HTML5 应用
这里主要讲的是思想。田行智老师以一个曾经日下载量1.5亿的HTML5游戏创始人身份分享他的经验和心得，以及HTML5+Native原生应用应该相符相成的理念。

HTML5的优势：

* 低开发成本
* A/B测试
* 随时上线
* 个性化功能

Native的优势：

* 高性能
* 大量数据处理
* 视觉表现力
* 强大的原生功能

HTML5是内容，应充分发挥它的高度灵活性。Native是载体，应充分发挥它的性能优势。

![egret](/assets/images/2015-03-25/htmlnative.png)

##End
就这么多吧。收获还是不错的，但是也就是看个热闹，要提高还是看自己的代码量。加油～





