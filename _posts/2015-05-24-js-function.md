---
layout: post
title: JavaScript 之函数
tag: Javascript
---

In JavaScript, functions are first-class objects, i.e. they are objects and can be manipulated and passed around just like any other object. Specifically, they are Function objects.

在 JavaScript 中，函数是一等公民。比如，函数是对象，像对象一样被操作或者传递给其他变量。更进一步地说，他们是函数对象。

以上。

#函数参数

从类型强弱上来分，Js 是一门非常非常弱鸡的语言。--by Rio

它不会因为你传的参数过多或过少而报运行时错误，如果传入的实参过多，那么它会用声明的那几个形参操作前几个实参，后面的全都可以用 `arguments` 来进行操作。。。极端情况下甚至都不用进行声明形参。如下例，计算传入参数的最大值。

{% highlight javascript%}
function max(/**可以操作任意数量的实参**/)
{
    var max=Number.NEGATIVE_INFINITY;
    for(var i=0;i<arguments.length;i++)
    {
        if(arguments[i]>max)
            max=arguments[i];
    }
    console.log(max);
}
max(1,2,100,-1,12345);
{% endhighlight %}

arguments[]里的参数也可以被修改，就像可以修改形参一样。

{% highlight javascript%}
function f(x) {
    console.log(x);
    arguments[0]=null;
    console.log(x);//参数被修改
}
f(10);
{% endhighlight %}

#this 关键字

Js中的this关键字非常有趣。
在大多数情况下，this 的值被函数调用方式所决定，它不能再函数执行过程中被修改。函数在不同地点调用的时候也可能有所不同。

[详解](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this)

`this`关键字没有作用域的限制，嵌套的函数不会从调用它的函数中继承`this`。如果嵌套函数作为方法调用，`this`的值会指向调用它的对象。如果嵌套函数作为函数调用，`this`的值不是全局对象（非严格模式）就是undefined（严格模式）

{% highlight javascript%}
var o = {
    m: function() {
        var self = this;// self 变量通常用来存储this，让嵌套函数使用。
        console.log(this === o);// true
        f();

        function f() {
            console.log(this === o);// false.非严格模式下：全局对象 严格模式下：undefined
            console.log(self === o);// true

            console.log(this);//chrome 里是window
        }
    }
};
o.m();
{% endhighlight %}

`this` on the object's prototype chain

`this` 在原型链上的传递。

{% highlight javascript%}
var o = {prop: 37};

function independent() {
  return this.prop;
}

o.f = independent;

console.log(o.f()); // logs 37
o.b = {g: independent, prop: 42};// o里的另一个对象。
console.log(o.b.g()); // logs 42
{% endhighlight %}

# 作为值的函数

函数可以作为参数传入。（在JS中，因为函数是一等公民，可以像变量一样扔来扔去的--by WCQ）

{% highlight javascript%}
// 和C一样，需要传入一个对每两个元素判断大小的函数
a = ['ant', 'Bug', 'cat', 'Dog'];
a.sort();               //不区分大小写的排序
console.log(a);
a.sort(function(s, t) { //区分大小写的排序
    var a = s.toLowerCase();
    var b = t.toLowerCase();
    if (a < b) return -1;
    if (a > b) return 1;
    return 0;
});
console.log(a);
{% endhighlight %}

#闭包

在JS函数对象的内部状态不仅包含函数的代码逻辑，还引用了当前的作用域链。如果调用函数的作用域链不同，函数当前的状态也是不同的。有可能会造成不同的输出。

{% highlight javascript%}
var scope = "global scope";

function checkscope() {
    var scope = "local scope";

    function f() {
        return scope;
    }
    return f;
}
console.log(checkscope()());// => 'local scope'
{% endhighlight %}

###闭包保护数据安全性

`uniqueInteger` 得到一个函数，每次执行`uniqueInteger()`可以得到一个依次增加的整数。和普通写法的优点在于，只有`uniqueInteger()`才能获得counter的访问权，其他函数无法修改。

{% highlight javascript%}
// counter
var uniqueInteger = (function() {
    var counter = 0;
    return function a() {
        return counter++;
    };
}());
{% endhighlight %}

另一种写法是把n作为函数参数存起来，有`get`和`set`来修改和访问。

{% highlight javascript%}
// store conter with argument
function counter(n) { // n is a private variable
    return {
        get count() {
            return n++;
        },
        set count(m) {
            if (m > n)
                n = m;
            else throw Error('count can only increase');
        }
    };
}
var c = counter(1000);
console.log(c);
console.log(c.count);
console.log(c.count);
console.log(c.count = 2000);
console.log(c.count = 3000);
console.log(c.count);
console.log(c.count = 3000);
{% endhighlight %}

#高阶函数
接收一个或多个函数为参数，可以返回一个新函数（在后面的例子中我们可以用高阶函数来打包一些新的工具函数）

一个更常见的例子，接收`f()`和`g()`返回一个新函数用于计算`f(g())`

{% highlight javascript%}
// calculate f(g())
function compose(f, g) {
    return function() {
        // f invoked with one argument, use call()
        // g invoked with arguments, use apply()
        return f.call(this, g.apply(this, arguments));
    };
}
{% endhighlight %}

#不完全函数

利用高阶函数的特性，我们可以打包不完全函数。通过不完全函数的打包，我们设置一个函数f()的部分实参，得到一个新函数g()，然后在需要的时候给g()赋上参数，相当于填补了f()所缺的剩下参数。根据先行填充实参的位置（从左填起、从右填起等等），我们可以分为`partialLeft()`、`partialRight()`、和`partial()`。当然你也可以自定义别的方式，比如隔一个填一个，隔两个填一个啦什么的。

传入参数个数不限，我仅仅用形参`f`指代了被打包的函数，其他全都用arguments来处理。

{% highlight javascript%}
// 将传入的arguments对象转化为真正的数组
function array(a, n) {
    return Array.prototype.slice.call(a, n || 0);
}

function partialLeft(f) { // 外部参数在左，内部参数在右
    var args = arguments;
    return function() {
        console.log(arguments);
        var a = array(args, 1);
        console.log(a);
        a = a.concat(array(arguments));
        return f.apply(this, a);
    }
}

function partialRight(f) { // 外部参数在右，内部参数在左
    var args = arguments;
    console.log(args);
    return function() {
        var a = array(arguments);
        a = a.concat(array(args, 1));
        return f.apply(this, a);
    }
}

function partial(f) {
    var args = arguments;
    return function() {
        var a = array(args, 1);
        var i = 0,
            j = 0;
        for (; i < a.length; i++) {
            if (a[i] === undefined)
                a[i] = arguments[j++];
        }
        a = a.concat(array(arguments, j));
        return f.apply(this, a);
    }
}

var f = function(x, y, z) {
    console.log(x + ' ' + y + ' ' + z);
    return x * (y - z);
};

// f(2,3,4)
console.log(partialLeft(f, 2)(3, 4)); // 给partialLeft传入(f,2) 给返回的匿名函数传入(3,4)

//f(3,4,2)
console.log(partialRight(f, 2)(3, 4));

//f(3,2,4)
console.log(partial(f, undefined, 2)(3, 4));
{% endhighlight %}

#函数式编程

重头戏来了，我们要用`compose()`和`partial()`打包一些工具函数。然后把工具函数组合起来，实现求平均数和标准差的功能。

{% highlight javascript%}
var map = Array.prototype.map ?
function(a, f) {
    return a.map(f);
} : function(a, f) {
    var results = [];
    for (var i = 0, len = a.length; i < len; i++) {
        if (i in a) // the in operator returns true if the specified property OR index is in the specified object
            results[i] = f.call(null, a[i], i, a);
    }
    return results;
};

var reduce = Array.prototype.reduce ?
function(a, f, initial) {
    if (arguments.length > 2) // 如果传入了初始值
        return a.reduce(f, initial);
    else {
        return a.reduce(f); // 否则没有初始值
    }
} : function(a, f, initial) {
    var i = 0,
        len = a.length,
        accumulator;
    if (arguments.length > 2) accumulator = initial;
    else {
        if (len == 0) throw TypeError();
        while (i < len) { // find the first defined index
            if (i in a) {
                accumulator = a[i++];
                break;
            } else i++;
        }
        if (i == len)
            throw TypeError();
    }

    while (i < len) {
        if (i in a)
            accumulator = f.call(accumulator, a[i], i, a);
        i++;
    }

    return accumulator;
};


var neg = partial(product, -1);
var square = partial(Math.pow, undefined, 2);
var sqrt = partial(Math.pow, undefined, .5);
var reciprocal = partial(Math.pow, undefined, -1);

var mean = product(reduce(data, sum), reciprocal(data.length));
var stddev = sqrt(
    product(reduce(map(data,compose(square,partial(sum, neg(mean)))),sum),reciprocal(sum(data.length, -1))));
    // map(data,partial(sum, neg(mean))) -3被partial()填到了 sum(x,y) 的 x 位置上。a[i] 被 map() 填到了不完全函数的缺口 y 里
console.log(mean);
console.log(stddev);
{% endhighlight %}