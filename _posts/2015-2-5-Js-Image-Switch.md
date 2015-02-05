---
layout: post
title: Javascript实现背景图片淡入淡出切换功能
tag: JavaScript
---


花了半天看javascript语法，再花半天写，也算是对Javascript有所心得吧。

[Demo](\open-up\Background-Image-Switch\index.html) 

[Code](https://github.com/ZhuFengdaaa/ZhuFengdaaa.github.io/blob/master/open-up/Background-Image-Switch/index.html)

先加载4张图片。

{% highlight html %}
<div id="background_cycler">
    <img id="img1" src="bcg1.jpg" style="opacity:0;" />
    <img id="img2" src="bcg2.jpg" style="opacity:0;" />
    <img id="img3" src="bcg3.jpg" style="opacity:0;" />
    <img id="img4" src="bcg4.jpg" style="opacity:0;" />
</div>
{% endhighlight %}
 
然后执行RandomStart()。随机选择一张opacity==0的图片使其opacity=1。

{% highlight javascript %}
function RandomStart() {
    i = Randompick();
    $('#img' + i).css('opacity', 1);
}
{% endhighlight %}

然后每隔5秒执行一次RandomChange()。随机一张opacity==0的和找到现在opacity==1的。执行淡入淡出。

{% highlight javascript %}
function RandomChange() {
    i = Randompick();
    // i fade in, j fade out
    for (j = 1; j <= Imgnum; j++) {
        if ($('#img' + j).css('opacity') == '1')
            break;
    }
    Fadeinout();
}
{% endhighlight %}

按一定的速率每执行一次该函数就把图片i变深一点，图片j变淡一点。
一些注意点：
* 在进行加减的时候要显示把字符串解析成float，不然会当成字符串处理，造成加减和比较时错误。
* Javascript没有min，max（可能有Math.min）不过我手写了一个。
* 因为javascript是异步调用，即单线程，诸如slee(s)这样的会打断异步。所以javascript没有暂停函数。一个for循环中有暂停的话，只能另写一个函数，然后用不停地递归调用来实现。
* setTimeout("Function name",time) 的参数传递。前一个是字符串参数，所以在调用的时候如果函数需要传参数，那么必须用 "Functionname("+i+","+j+")",time) 的方式进行调用。（后来我就索性没写，全都开全局变量。）

{% highlight javascript %}
function Fadeinout()
{
	$('#img' + i).css('opacity', Min(parseFloat($('#img' + i).css('opacity')) + changeValue, 1)); 
    $('#img' + j).css('opacity', Max(parseFloat($('#img' + j).css('opacity')) - changeValue, 0.0));
    console.log($('#img' + i).css('opacity'));
    console.log($('#img' + j).css('opacity'));
    if(($('#img' + i).css('opacity')==1)&&($('#img' + j).css('opacity')==0))
    {
    	//alert('abort');
    	$('#img'+i).css('opacity',1);
    	$('#img'+j).css('opacity',0);
    	return;
    }
    setTimeout("Fadeinout()",Period*1000);
}
{% endhighlight %}













