---
layout: post
title: 继承VS接口（Thread与runnable的比较）
tag: Java
---

我们一直以一个API的使用者的角度来比较Java中继承和接口的区别。这里我不想详述，[这篇博文](http://blog.csdn.net/chenssy/article/details/12858267)从作用和设计理念两方面叙述得很好了。

今天我们来从API设计者的角度出发，以我们最耳熟能详的多线程调用，`extends Thread 和 implements Runnable`来探究Java中继承和接口的实现方式。

不知道大家想过没有，我们写一个类，实现Runnable接口，重写`run()`函数了以后，就可以用这个类来创建多线程，`run()`里面的代码会被反复调用。那么请问多线程运行过程中需要的其他函数怎么实现？

如果你已经思考清楚了这个问题，那么恭喜你，这篇博文对你来说已经是隔年皇历。如果你和当时的我一样疑惑这个问题，那么接下来你要仔细看了。

我们先比较一下两种方法实现多线程调用上的区别
[source](http://docs.oracle.com/javase/tutorial/essential/concurrency/runthread.html)
{% highlight java %}
public class HelloThread extends Thread {
    public void run() {
        System.out.println("Hello from a thread!");
    }
    public static void main(String args[]) {
        (new HelloThread()).start();
    }
}
{% endhighlight %}

{% highlight java %}
public class HelloRunnable implements Runnable {
    public void run() {
        System.out.println("Hello from a thread!");
    }
    public static void main(String args[]) {
        (new Thread(new HelloRunnable())).start();
    }
}
{% endhighlight %}

###开源的JDK
JDK是开源的，从JDK6开始，你在JDK安装目录下可以找到src.zip这个文件，就是其源代码，可以导入eclipse的。
导入JDK源代码后，在你的代码里按住Ctrl并点类名或方法名就看到源代码了。

但是JDK底层实际上为了跨平台用的是C/C++调用平台本身的功能，这部分JDK的src.zip不包含，但是在Oracle领导的OpenJDK这个项目里面可以看到其开源实现。

* [Runnable.java](/files/Runnable.java) 
* [Thread.java](/files/Thread.java)

接下来我们把Runnable.java和Thread.java进行仿写，理解通过继承和接口两个不同方法来实现同一个功能的区别。

###仿写
![navigator](\assets\images\2015-03-03\navigator.jpg)

模仿runnable，runnable接口下只有一个函数`run()`。
{% highlight java %}
//Animal.java (interface)
package interfacetest;
public interface Animal {
	abstract String run();
}
{% endhighlight %}


{% highlight java %}
//developer.java (模仿Thread的类)
package developer;
import interfacetest.Animal;;
public class developer implements Animal{
	Animal target;
	public String run() {
		if(target!=null)
			return target.run();
		else return null;
	}
	public void display() {
		System.out.println(""+run());
	}
	public developer() {
		
	}
	public developer(Animal target) {
		this.target=target;
	}
}
{% endhighlight %}

{% highlight java %}
//Cat.java (继承实现)
package interfacetest;
import developer.developer;
public class Cat extends developer{
	@Override
	public String run() {
		return "Cat run";
	}
}
{% endhighlight %}


{% highlight java %}
//Dog.java (接口实现)
package interfacetest;
import developer.developer;
public class Dog implements Animal{
	public String run() {
		return "Dog run";
	}
}
{% endhighlight %}

{% highlight java %}
//MainActivity.java (测试类)
package interfacetest;
import developer.developer;
import interfacetest.Cat;
import interfacetest.Dog;
public class MainActivity {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Cat c = new Cat();
		Dog d = new Dog();
		c.display();
		new developer(d).display();
	}
}
{% endhighlight %}

{% highlight java %}
//测试结果
Cat run
Dog run
{% endhighlight %}

结论是一致的，建议使用接口以获得更多扩展。因为一个Class只能继承一个父类，但是可以实现多个接口。