# JUC高并发

### JUC含义
- java.util.concurrent
- java.util.concurrent.atomic
- java.util.concurrent.locks
> 指代这三个包，主要用于并发编程

### volatile与
#### volatile是Java虚拟机提供的轻量级的同步机制
- 保证可见性
- 不保证原子性
- 禁止指令重排

#### JMM(java内存模型，Java Memory Model)
&emsp;&emsp;本身是一种抽象的概念并不真实存在，它描述的是一组规则或规范，通过这组规范定义了程序中各个变量(包括实体字段，静态字段和构成数组对象的元素)的访问方式
JMM关于同步的规定：
- 线程解锁前，必须把共享内存的值刷回主内存
- 线程加锁前，必须读取主内存的最新值到自己的工作内存
- 加锁解锁是同一把锁