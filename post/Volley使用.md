Date: 2015-05-21
Title: volley使用教程
Tags: Android
Author: summer
Abstract: 介绍了volley的常见用法


##volley的安装
  Volley的安装比较麻烦，网上说是从google code上clone下来然后编译成jar包，但是我从来没有下载成功过。说下两种方法吧：
* 下载源码编译
```
$ git clone https://android.googlesource.com/platform/frameworks/volley
$ cd volley
$ android update project -p .
$ ant jar
```
* 如果你使用AS来开发，可以使用gradle添加
```
dependencies {
    compile 'com.mcxiaoke.volley:library:1.0.15'
}
```

##使用Context的场景
  * Activity
  * Service 
  * BroadcastReceiver

##getApplicationContext 和 MyActivity.this的区别
  首先说一下为什么是MyActivity.this 而不是 MyActivity,我们知道Activity是间接继承Context类的，我们要传入的是一个Context对象时（注意是一个对象），如果只写MyActiviy,这是一个类名，并不是具体的视力，也没有进行初始化（除了静态方法），而MyActivity.this 这是一个对象，当程序运行时，会自动传递当前创建的对象.
  每个App都有一个Application的实例，这个Context是全局的，生命周期和App一样长。
  当我们编写一些工具类是常常会用到单利模式，而这些类常常需要传入一个Context对象。例如:
```java
  public class CustomManager {
        private static CustomManager sInstance;
        private Context mContext;
     
        private CustomManager(Context context)
        {
            this.mContext = context;
        }
     
        public static synchronized CustomManager getInstance(Context context)
        {
            if (sInstance == null)
            {
                sInstance = new CustomManager(context);
            }
            return sInstance;
        }
    }
```
