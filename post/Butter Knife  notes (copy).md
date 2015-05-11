Date: 2015-03-26
Title: ButterKnife NOTES
Tags: ButterKnife
Author: xiah
Abstract: ButterKnife 使用总结,包括view的注入，点击事件的处理

#Butter Knife notes

在使用Butter Knife时，你需要下载相应的jar包，如果你使用的是gradle，在build.gradle中添加：
```
compile 'com.jakewharton:butterknife:6.1.0'
```
如果使用Maven，在pom文件中添加:
```
<dependency>
<groupId>com.jakewharton</groupId>
<artifactId>butterknife</artifactId>
<version>6.1.0</version>
</dependency>
```
如果使用Eclipse开发，可以在[Butter Knife官网](http://jakewharton.github.io/butterknife/ "ButterKnife")下载最新的jar包，并拷贝到libs目录下。

##inject view
```java
class ExampleActivity extends Activity {
  @InjectView(R.id.title) TextView title;
  @InjectView(R.id.subtitle) TextView subtitle;
  @InjectView(R.id.footer) TextView footer;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContView(R.layout.simple_activity);
    ButterKnife.inject(this);
  }
}
```
