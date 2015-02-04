---
layout: post
title: JS Essay
tag: JavaScript
---

* 获得网页的背景元素Url `document.background.url`
* javascript 字符串可以相加 str3=str1+str2;
* 一段时间后执行某函数：
     - setInterval("func"，时间)：页面载入后，每经过指定毫秒值后执行定表达式，是间隔多次执行的
    - setTimeout("func"，时间)：页面载入后，经过指定毫秒值后执行指定表达式，只执行一次
* Javascript 获取元素背景图片: element.style.backgroundImage

###关于Chrome开发者工具
[官方网站](https://developer.chrome.com/devtools)

####打开开发者工具

* 按`F12` 或 `Ctrl+Shift+I`
* 点击右上角的菜单栏 选择 工具->开发者工具
* 在页面上任何元素上单击右键，选择 “审查元素”
* 如果要直接打开开发者工具中的命令行模式（console） 按`Ctrl+Shift+J`

####审查元素面板

最左边的Element面板就是网页元素面板，在这个**文档对象模型（DOM）**结构树中你可以看到所有元素及他们的状态。你也可以双击进行编辑，任意改变DOM元素。在你查看网页的HTML代码时常常会用它来访问某元素的标签内容。比如你对网页上的一张图片感兴趣，那你就会用 “审查元素” 查看这张图片是否有一个id属性，属性的值是什么。 

![元素面板](\assets\images\2015-02-04\elements-panel.png)
 - 
 







