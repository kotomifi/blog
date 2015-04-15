Date: 2015-04-15
Title: Android的消息处理机制
Tags: Android, Handler, Looper
Author: xiah
Abstract: 在Android中经常需要在Activity和Service之间进行通信，或者是和其它线程之间进行通信，本文介绍了Android的消息处理机制

#Android消息处理


##Looper介绍
当我们用Thread或者Runnable创建一个线程时，这个线程是没有消息队列和消息循环的。在Android中，如果想使用消息队列和消息循环可以使用Looper类来实现，具体代码如下：
```java
public class LooperThread extends Thread {
    @Override
    public void run() {
        //init current thread to a looper thread
        Looper.prepare();

        //your work
        ...

        //start loop message quene
        Looper.loop();
    }
}
```
  通过上面的两行代码，我们的线程升级为Looper线程。在了解Looper之前我们先了解下ThreadLocal这个类。
ThreadLocal并不是一个线程，而是一个线程的本地化对象。当一个变量使用ThreadLocal进行维护时，
ThreadLocal为使用该变量的每个线程分配一个独立的变量副本，每个线程可以自行操作自己对应的变量副本，而不会影响其它线程的变量副本。



下面我们看下Looper的源码，看看Looper类具体做了什么
在Looper类中定义了两个局部变量final MessageQueue mQueue和final Thread mThread。当我们调用Looper.prepare()方法时，会调用Looper的私有构造函数来初始化mQueue(新建消息队列)和mThread(保存当前Thread)

```java
public final class Looper {
    private static final String TAG = "Looper";

    // sThreadLocal.get() will return null unless you've called prepare().
    static final ThreadLocal<Looper> sThreadLocal = new ThreadLocal<Looper>();
    private static Looper sMainLooper;  // guarded by Looper.class

    final MessageQueue mQueue;
    final Thread mThread;

    private Printer mLogging;

     /** Initialize the current thread as a looper.
      * This gives you a chance to create handlers that then reference
      * this looper, before actually starting the loop. Be sure to call
      * {@link #loop()} after calling this method, and end it by calling
      * {@link #quit()}.
      */
    public static void prepare() {
        prepare(true);
    }

    private static void prepare(boolean quitAllowed) {
        if (sThreadLocal.get() != null) {
            throw new RuntimeException("Only one Looper may be created per thread");
        }
        sThreadLocal.set(new Looper(quitAllowed));
    }

    /**
     * Initialize the current thread as a looper, marking it as an
     * application's main looper. The main looper for your application
     * is created by the Android environment, so you should never need
     * to call this function yourself.  See also: {@link #prepare()}
     */
    public static void prepareMainLooper() {
        prepare(false);
        synchronized (Looper.class) {
            if (sMainLooper != null) {
                throw new IllegalStateException("The main Looper has already been prepared.");
            }
            sMainLooper = myLooper();
        }
    }

    /** Returns the application's main looper, which lives in the main thread of the application.
     */
    public static Looper getMainLooper() {
        synchronized (Looper.class) {
            return sMainLooper;
        }
    }

    /**
     * Run the message queue in this thread. Be sure to call
     * {@link #quit()} to end the loop.
     */
    public static void loop() {
        final Looper me = myLooper();
        if (me == null) {
            throw new RuntimeException("No Looper; Looper.prepare() wasn't called on this thread.");
        }
        final MessageQueue queue = me.mQueue;

        // Make sure the identity of this thread is that of the local process,
        // and keep track of what that identity token actually is.
        Binder.clearCallingIdentity();
        final long ident = Binder.clearCallingIdentity();

        for (;;) {
            Message msg = queue.next(); // might block
            if (msg == null) {
                // No message indicates that the message queue is quitting.
                return;
            }

            // This must be in a local variable, in case a UI event sets the logger
            Printer logging = me.mLogging;
            if (logging != null) {
                logging.println(">>>>> Dispatching to " + msg.target + " " +
                        msg.callback + ": " + msg.what);
            }

            msg.target.dispatchMessage(msg);


            // Make sure that during the course of dispatching the
            // identity of the thread wasn't corrupted.
            final long newIdent = Binder.clearCallingIdentity();

            msg.recycleUnchecked();
        }
    }

    /**
     * Return the Looper object associated with the current thread.  Returns
     * null if the calling thread is not associated with a Looper.
     */
    public static Looper myLooper() {
        return sThreadLocal.get();
    }

    /**
     * Control logging of messages as they are processed by this Looper.  If
     * enabled, a log message will be written to <var>printer</var> 
     * at the beginning and ending of each message dispatch, identifying the
     * target Handler and message contents.
     */
    public void setMessageLogging(Printer printer) {
        mLogging = printer;
    }
    
    /**
     * Return the {@link MessageQueue} object associated with the current
     * thread.  This must be called from a thread running a Looper, or a
     * NullPointerException will be thrown.
     */
    public static MessageQueue myQueue() {
        return myLooper().mQueue;
    }

    private Looper(boolean quitAllowed) {
        mQueue = new MessageQueue(quitAllowed);
        mThread = Thread.currentThread();
    }

    /**
     * Returns true if the current thread is this looper's thread.
     * @hide
     */
    public boolean isCurrentThread() {
        return Thread.currentThread() == mThread;
    }

    /**
     * Quits the looper.
     *
     * @see #quitSafely
     */
    public void quit() {
        mQueue.quit(false);
    }

    /**
     * Quits the looper safely.
     */
    public void quitSafely() {
        mQueue.quit(true);
    }

    /**
     * Posts a synchronization barrier to the Looper's message queue.
     */
    public int postSyncBarrier() {
        return mQueue.enqueueSyncBarrier(SystemClock.uptimeMillis());
    }


    /**
     * Return the Thread associated with this Looper.
     */
    public Thread getThread() {
        return mThread;
    }

    /** @hide */
    public MessageQueue getQueue() {
        return mQueue;
    }

    /**
     * Return whether this looper's thread is currently idle, waiting for new work
     * to do.  This is intrinsically racy, since its state can change before you get
     * the result back.
     * @hide
     */
    public boolean isIdling() {
        return mQueue.isIdling();
    }

    public void dump(Printer pw, String prefix) {
        pw.println(prefix + toString());
        mQueue.dump(pw, prefix + "  ");
    }
}
```
##handler介绍
