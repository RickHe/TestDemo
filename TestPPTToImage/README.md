# TestPPTToImage
##### 公司最近提了个将 PPT 转成图片并显示需求，经过各种查资料终于实现，分享一下思路！

首先一个 UIView 对象要转换成一张图片，我们可以使用如下代码：
``` 
    UIGraphicsBeginImageContext(boundsSize); 
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
```
于是我想到了使用可以展示 ppt 文件的 UIWebView 来展示 ppt 文件：
``` 
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"iOS" ofType:@"pptx"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    webView.scrollView.minimumZoomScale = 0;
    webView.scrollView.maximumZoomScale = 1;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
``` 
接下来就是将 UIWebView 的每一个 page 渲染成一张图片并保存！
__渲染思路如下：__
* 打印webview 的 html ，并观察html 文件的结构
```
    // 打印 html 文件
    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
``` 
``` 
    // html 结构
    <div class="slide" style="position:absolute; overflow:hidden; top:0; left:0; width:959; height:540;">
    <div class="slide" style="position:absolute; overflow:hidden; top:1635; left:0; width:959; height:540;">
...
```
* 观察 html 文件我们发现每一页 ppt 就是一个div class="slide"，所以我们可以使用iOS 调用 js 代码获取到 ppt 的长宽，顶部位置以及 ppt 的总页数等属性
```
    NSUInteger pageCount = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('slide').length"] intValue];
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.height", _currentPage]] floatValue];
    CGFloat width= [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.width", _currentPage]] floatValue];
    CGFloat offset = [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.top", _currentPage]] floatValue];
```
* 获取到这些属性后，我们可以设置webView的大小为 pdf 页面的大小，webView 的 scrollView 的contentOffset，设置 webView 显示的偏移。使用如下代码为每一页生成 UIImage
```
  webView.bounds = CGRectMake(0, 0, width, height);
  [webView.scrollView setContentOffset:CGPointMake(0, offset)];
  UIGraphicsBeginImageContext(boundsSize); 
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
```
以上可实现 PPT 转成图片功能
###### 然而经压力测试发现黑屏闪退
md，内存泄露！
通过 instrument 测试发现  [view.layer renderInContext:UIGraphicsGetCurrentContext()];内存一直不释放！oh my god！
查资料得出的思路
```
    self.view.layer.contents = nil;
```
然而并没有卵用
借鉴查找到的思路，最终我采取的策略是：每加载一次 webView 我只 render 一次， 移除掉 webView 然后再加载 webView 再 render
 ```
    [webview removeFromSuperview];
    webview = nil;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"iOS" ofType:@"pptx"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    webView.scrollView.minimumZoomScale = 0;
    webView.scrollView.maximumZoomScale = 1;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
```
这种做法虽然效率很低但是闪退的问题解决了！
当然也可以将粒度调高一点，比如每加载一次 webView，render 5页或者10页，这个可以根据个人需求去优化！

###### 需要完整代码的可以[点击这里](https://github.com/RickHe/TestPPTToImage)
