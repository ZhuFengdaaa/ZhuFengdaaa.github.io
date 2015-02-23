---
layout: post
title: 安卓入门-1
tag: Android
---

AndroidManifest.xml 告诉Android操作系统要运行的应用的API信息，SDK版本，android:theme 。

layout 文件夹，存放UI界面的XML文件。

An Activity can use any layout file. It is not just linked to this one forever.

####日志输出 Log

`Log.d(string , string);` Log.后面的字母代表不同的日志类型 ，.d代表debug , .e代表error , .i代表information , .v代表verbose , .w代表warning。

####设置activity 背景颜色
{% highlignt html %}
<Linearlayout android:background="#343434"(灰色)/>
{% endhighlight%}

####layout Button 居中
{% highlight html %}
<Button 
    android: layout_gravity="center"
    />
{% endhighlight %}