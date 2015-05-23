Date: 2015-05-21
Title: Android Context详解
Tags: Android
Author: summer
Abstract: 介绍了Android Context的概念，使用场景


##Context的概念
  Context翻译成中文就是上下文的意思，根据Google给出的解释，Context有如下特性：
  * Context描述了应用的信息
  * Context是一个抽象类，Android提供了该类的具体实现类
  * 通过Context可以访问应用程序的资源和类，也包括一些应用级别的操作（启动Activiyt, 发送广播，接收Intent信息）

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