# CheckUpdateiOS
时间比较紧急写的，欢迎大家来完善。 

##   使用iOS自动更新检测

在App提交到appStore后，通过app store上查询，可以获取到app的作者，连接，版本等。
[点击查看官方文档](http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.htm)

可以通过如下请求得到App的详细信息：
http://itunes.apple.com/lookup?id=应用程序的ID
具体就不再细说了。

------

在Xcode工程中导入相关代码

1.加载头文件`#import "UMCheckUpdate.h"`

2.然后在`–application:didFinishLaunchingWithOptions:`中添加

``` 
[UMCheckUpdate checkUpdateWithAppID:(NSString *)appId];
```

`appId` 是app在appstore的ID

3.部分情况下，检测更新的地址和App的主页地址和默认的可能有点不一样。

这个时候就需要用

``` 
+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl;
```

`checkUrl` 是上面提到的检测更新的地址
`homeUrl` 是app在appstore主页的地址

4.如果想对`UIAlertView`的标题和按钮文字做多国语言支持，则需要对下面三个词组做翻译。

> `umUpdateTitle` ：标题
> 
> `umUpdateCancel` : 放弃按钮
> 
> `umUpdateOK` : 确定按钮

当然您可以更简单的自定义标题和按钮的文字

``` 
+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelTitle
           otherButtonTitles:(NSString *)otherTitle;
```
------

5.App有两个版本号，一个是`Version`,另一个是`Build`,对应于Info.plist的字段名分别为`CFBundleShortVersionString`,`CFBundleVersion`。 AppSotre默认取的是`Version`号。


