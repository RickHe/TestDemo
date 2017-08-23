//
//  DFCFileToPDF.m
//  planByGodWin
//
//  Created by DaFenQi on 16/12/22.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCPPTToImage.h"

#define kTempImagePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempImage"]

@interface DFCPPTToImage () <UIWebViewDelegate> {
    NSUInteger _currentPage;
    NSUInteger _pageCount;
    NSMutableArray *_imagePaths;
    UILabel *_tipLabel;
}

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, weak) id <DFCPPTToImageDelegate> delegate;

@end

@interface UIPrintPageRenderer (PDF)

- (NSData*) printToPDF;

@end

@implementation DFCPPTToImage

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webView];
    
    _currentPage = 0;
    _imagePaths = [NSMutableArray new];
}

- (UIWebView *)webView {
    UIWebView *_webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webview.scalesPageToFit = YES;
    _webview.scrollView.minimumZoomScale = 0;
    _webview.scrollView.maximumZoomScale = 1;
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    [_webview loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    _tipLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    _tipLabel.backgroundColor = [UIColor whiteColor];
    _tipLabel.font = [UIFont systemFontOfSize:28];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipLabel];
    
    return _webview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)createPdfWithURL:(NSURL *)url
                        delegate:(id <DFCPPTToImageDelegate>)delegate {
    return [[DFCPPTToImage alloc] initWithURL:url
                                     delegate:delegate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)terminateWebTask {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    [self.view removeFromSuperview];
}

- (instancetype)initWithURL:(NSURL *)url
                   delegate:(id <DFCPPTToImageDelegate>)delegate{
    if (self = [super init]) {
        self.url = url;
        self.delegate = delegate;
    
        [self forceLoadView];
    }
    return self;
}

- (void)forceLoadView {
    [[UIApplication sharedApplication].delegate.window addSubview:self.view];
}

#pragma mark - webView
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (webView.isLoading) return;
        // NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
        // ppt 总页数
        _pageCount = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('slide').length"] intValue];
        
        // ppt 宽高
        CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.height", _currentPage]] floatValue];
        CGFloat width= [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.width", _currentPage]] floatValue];
        webView.bounds = CGRectMake(0, 0, width, height);
        
        // ppt 每一页相对的偏移
        CGFloat offset = [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('slide')[%li].style.top", _currentPage]] floatValue];
        [webView.scrollView setContentOffset:CGPointMake(0, offset)];
        
        // 渲染图片
        [self imageRepresentation:webView
                       boundsSize:CGSizeMake(width, height)];
        
        if (_currentPage == _pageCount) {
            if ([self.delegate respondsToSelector:@selector(pptToImageDidSucceed:imagePaths:)]) {
                [self terminateWebTask];
                [self.delegate pptToImageDidSucceed:self
                                         imagePaths:_imagePaths];
            }
        }
    });
}

- (void)imageRepresentation:(UIWebView *)webView
                       boundsSize:(CGSize)boundsSize {
    @autoreleasepool {
        UIGraphicsBeginImageContext(boundsSize);
        [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
        NSString *imgPath = [[self tempImagePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.jpg", (unsigned long)_currentPage]];
    
        _currentPage++;
        
        [imgData writeToFile:imgPath atomically:YES];
        [_imagePaths addObject:imgPath];
        
        [webView removeFromSuperview];
        webView = nil;
        
        if (_currentPage < _pageCount) {
            [self webView];
            _tipLabel.text = [NSString stringWithFormat:@"%li %li", _currentPage, _pageCount];
            NSLog(@"%li %li",_currentPage, _pageCount);
        } else {
            NSLog(@"finish");
        }
    }
}

- (NSString *)tempImagePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kTempImagePath]) {
        [fileManager createDirectoryAtPath:kTempImagePath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return kTempImagePath;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView.isLoading) return;
    
    [self terminateWebTask];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pptToImageDidFail:)])
        [self.delegate pptToImageDidFail:self];
}

@end

