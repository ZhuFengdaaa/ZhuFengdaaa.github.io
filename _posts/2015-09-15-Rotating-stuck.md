---
layout: post
title: 旋转卡壳二三题
tag: Algorithm
---

###形象生动的图解→_→

![](http://pic002.cnblogs.com/images/2011/139826/2011040318073013.gif)

###参考资料
[旋转卡壳初步](http://www.cnblogs.com/Booble/archive/2011/04/03/2004865.html)

##bjoj 1185 最小矩形覆盖
[题目连接](http://www.lydsy.com/JudgeOnline/problem.php?id=1185)

题目大意: 给你一些平面上的点,(有x,y坐标).求一个能覆盖所有点的面积最小的矩形.

解题思路: 先作一个凸包(从意义上来讲就是先作一个覆盖所有这些点的凸多边形)，然后再这个凸多边形的基础上用旋转卡壳做出一个面积最小的矩形。枚举每条边，找到对踵点，再找最左端点和最右端点。**注意:** 第一次找最左点和最右点是一个坑，因为枚举每条边是按一个方向的(比如顺时针方向)，那么第i+1次得到的最左点一定在第i次的最左点的顺时针方向的下游，同理，第i+1次得到的最右点也一定在第i次的最右点的顺时针方向的下游。因此我们枚举第一条边的时候，先找到对踵点，然后按顺时针方向来说的话，应该先找最右点，然后以最右点为基础找最左点。而以后的枚举中，第i+1个最左点以第i个为基础。


{% highlight C %}
// 在所有点中选取y坐标最小的一点H，当作基点。如果存在多个点的y坐标都为最小值，则选取x坐
// 标最小的一点。坐标相同的点应排除。然后按照其它各点p和基点构成的向量<H,p>与x轴的夹角进
// 行排序，夹角由大至小进行顺时针扫描，反之则进行逆时针扫描。实现中无需求得夹角，只需根据
// 向量的内积公式求出向量的模即可。

#include <iostream>
#include <cstdio>
#include <algorithm>
#include <cmath>
const double eps = 1e-9; 
using namespace std;

int n,top=0;
double H,D,R,L;
double ans=1e60;
struct P{
	double x,y;
	P(){}
	P(double _x,double _y):x(_x),y(_y){}
	friend bool operator<(P a,P b){
		return fabs(a.y-b.y)<eps?a.x<b.x:a.y<b.y;
	}
	friend bool operator==(P a,P b){
		return fabs(a.x-b.x)<eps&&fabs(a.y-b.y)<eps;
	}
	friend bool operator!=(P a,P b){
		return !(a==b);
	}
	friend P operator+(P a,P b){
		return P(a.x+b.x,a.y+b.y);
	}
	friend P operator-(P a,P b){
		return P(a.x-b.x,a.y-b.y);
	}
	friend double operator*(P a,P b){
		return a.x*b.y-a.y*b.x;
	}
	friend P operator*(P a,double b){
		return P(a.x*b,a.y*b);
	}
	friend double operator/(P a,P b){
		return a.x*b.x+a.y*b.y;
	}
	friend P operator/(P a,double b){
		return P(a.x/b,a.y/b);
	}
	friend double dis(P a){
		return sqrt(a.x*a.x+a.y*a.y);
	}
}p[50005],q[50005],t[10];

// P i/P j 叉积
double polarAngle(P i,P j)
{
	return i/dis(i)/dis(j)/j;// divide constant first to prevent overflow
}
bool cmp(P i,P j)
{
	P x;
	x.x=1;
	x.y=0;
	return polarAngle(i-p[0],x)>polarAngle(j-p[0],x);
}
void graham()//求凸包，graham算法
{
	for(int i=1;i<n;i++)
	{
		if(p[i]<p[0])swap(p[0],p[i]);
	}
	sort(p+1,p+n,cmp);
	q[top++]=p[0];
	P x;
	x.x=1;
	x.y=0;
	for(int i=1;i<n;i++)
	{
		while(top>1&&(p[i]-q[top-1])*(q[top-1]-q[top-2])>-eps)top--; // top>1 这个条件不能忘; >= 用小于等于把处在凸包边上的点也包括进来; 判断一个点在直线的顺时针测还是逆时针侧用叉积
		q[top++]=p[i];
	}
	q[top]=q[0];
}


void RC()// Rotating calipers
{
	int r=1,l=1,p=1;
	for(int i=0;i<top;i++)
	{
		D=dis(q[i+1]-q[i]);
		while((q[i+1]-q[i])*(q[p+1]-q[i+1])-(q[i+1]-q[i])*(q[p]-q[i+1])>-eps){p=(p+1)%top;}
		while(((q[i+1]-q[i])/(q[r+1]-q[i+1])-((q[i+1]-q[i])/(q[r]-q[i+1])))>-eps){r=(r+1)%top;}
		if(i==0)l=r;
		while(((q[i+1]-q[i])/(q[l+1]-q[i])-((q[i+1]-q[i])/(q[l]-q[i])))<eps){l=(l+1)%top;}
		
		// printf("l= %d r= %d p= %d\n",l,r,p);

		R=((q[r]-q[i])/(q[i+1]-q[i]))/D;
		L=((q[l]-q[i])/(q[i+1]-q[i]))/D;
		H=fabs((q[p]-q[i+1])*(q[i+1]-q[i]))/D;
		P v;
		v.x=-(q[i+1]-q[i]).y;
		v.y=(q[i+1]-q[i]).x;
		v=v/D;
		if(i==0){// 第一次的特判
			ans = H*(R-L);
			t[0]=q[i]+(q[i]-q[i+1])/D*fabs(L);
			t[1]=t[0]+(q[i+1]-q[i])/D*(R-L);
			t[2]=t[1]+v*H;
			t[3]=t[0]+t[2]-t[1];
		}
		else if(H*(R-L)-ans<-eps)
		{
			ans = H*(R-L);
			t[0]=q[i]+(q[i]-q[i+1])/D*fabs(L);
			t[1]=t[0]+(q[i+1]-q[i])/D*(R-L);
			t[2]=t[1]+v*H;
			t[3]=t[0]+t[2]-t[1];
		}
	}
}

int main()
{
	scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		scanf("%lf %lf",&p[i].x,&p[i].y);
	}
	graham();
	RC();
	printf("%.5f\n",ans);
	int minst=0;
	for(int i=0;i<4;i++)
	{
		if(t[i]<t[minst])
			minst=i;
	}
	for(int i=0;i<4;i++)
	{
		printf("%.5f %.5f\n",t[(i+minst)%4].x,t[(i+minst)%4].y);
	}
}
/*
3
1 0
0 1
1 1

6
1.0 3.0
1.0 4.0
2.0 1.0
3.0 0.0
3.0 6.0
6.0 3.0

8
1.0 3.0
1.0 4.0
2.0 1.0
3.0 3.0
4.0 3.0
3.0 0.0
3.0 6.0
6.0 3.0
*/

{% endhighlight %}

##poj2187 Beauty Contest 平面最远点对

题意：给你n个点，问距离最远的两个点的距离的平方是多少。
思路: 最远点对一定在凸包上，所以枚举凸包上的点即可。旋转卡壳枚举边和対踵点，分别计算対踵点到边两端点的距离，维护一个最大值即可。(思路很简单，但是故意用int卡你，对算法和模板的理解很重要，不然会被卡精度)


{% highlight C %}
#include <iostream>
#include <cstdio>
#include <cstring>
#include <cmath>
#include <algorithm>
using namespace std;
const int V = 50005;
int n,top;
struct P //模板里的类型都得改
{
	int x,y;
	// constructor
	P(){this->x=0;this->y=0;}
	P(int x,int y):x(x),y(y){}

	// y first
	friend bool operator<(P a,P b)
	{
		return abs(b.y-a.y)==0?a.x<b.x:a.y<b.y;
	}
	friend bool operator>(P a,P b)
	{
		return abs(a.y-b.y)==0?a.x>b.x:a.y>b.y;
	}
	friend P operator+(P a,P b)
	{
		return P(a.x+b.x,a.y+b.y);
	}
	friend P operator-(P a,P b)
	{
		return P(a.x-b.x,a.y-b.y);
	}
	friend P operator*(P a,int b)
	{
		return P(a.x*b,a.y*b);
	}
	friend P operator/(P a,int b)
	{
		return P(a.x/b,a.y/b);
	}
	// 
	friend int operator*(P a,P b)
	{
		return a.x*b.y-a.y*b.x;
	}
	// 
	friend int operator/(P a,P b)
	{
		return a.x*b.x+a.y*b.y;
	}

	// square of distance PS: 因为卡int，所以不敢乱开方，直接return平方
	friend int dis(P a)
	{
		return a.x*a.x+a.y*a.y;
	}
}p[V],q[V];
bool cmp(P a,P b)
{
	int t=(a-p[0])*(b-p[0]);
	if(t==0)return dis(p[0]-a)-dis(p[0]-b)<0;
	else return (a-p[0])*(b-p[0])>0;
}
void Graham()
{
	for(int i=1;i<n;i++)
		if(p[i]<p[0])swap(p[i],p[0]);
	sort(p+1,p+n,cmp);
	q[top++]=p[0];
	for(int i=1;i<n;i++)
	{
		while(top>1 && (p[i]-q[top-1])*(q[top-1]-q[top-2])>=0)top--;
		q[top++]=p[i];
	}
	q[top]=q[0];// 这里很重要，为了下一步的旋转卡壳做准备。老是忘。
	// for(int i=0;i<=n;i++)
	// {
	// 	printf("%d %d\n",p[i].x,p[i].y);
	// }
}
bool line()// 特殊情况，判断是否是一条直线,旋转卡壳在直线上不适用？不合理啊？现在看应该是当时写残了
{
	for(int i=2;i<top;i++)
	{
		if(abs((q[i-1]-q[i-2])*(q[i]-q[i-1]))>0)
			return false;
	}
	return true;
}
void RC()
{
	int p=1;// Antipodal point
	int res=0;
	if(line()){
		for(int i=1;i<top;i++)
			if(res<dis(q[i]-q[0]))
				res=dis(q[i]-q[0]);
	}
	else{
		for(int i=1;i<=top;i++){
			while(abs((q[p+1]-q[i])*(q[i]-q[i-1]))-abs((q[p]-q[i])*(q[i]-q[i-1]))>=0)
				p=(p+1)%top;
			if(dis(q[p]-q[i-1])>res)
				res=dis(q[p]-q[i-1]);
			if(dis(q[p]-q[i])>res)
				res=dis(q[p]-q[i]);
		}
	}
	printf("%d\n",res);
}
int main()
{
	scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		scanf("%d%d",&p[i].x,&p[i].y);
	}
	if(n==2){
		printf("%d\n",dis(p[0]-p[1]));
		return 0;
	}
	Graham();
	RC();
}
/*
7
0 0
2 0
0 1
0 2
-1 1
1 0
1 1

8
1 3
1 4
2 1
3 3
4 3
3 0
3 6
6 3
*/
{% endhighlight %}
