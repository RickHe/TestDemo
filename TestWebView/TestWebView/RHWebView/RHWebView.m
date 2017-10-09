//
//  RHWebView.m
//  TestWebView
//
//  Created by DaFenQI on 2017/9/29.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHWebView.h"
#import "NJKWebViewProgress.h"

#define RHProgressViewFrame CGRectMake(0, 0, self.bounds.size.width , 10)
#define RHIndicatorViewFrame CGRectMake(0, 0, 30, 30)

@interface RHWebView () <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    UIWebView *_webView;
    UIActivityIndicatorView *_indicatorView;
    NJKWebViewProgress *_progressProxy;
    UIProgressView *_progressView;
}

@end

@implementation RHWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _webView.frame = self.bounds;
    _progressView.frame = RHProgressViewFrame;
    _indicatorView.frame = RHIndicatorViewFrame;
    _indicatorView.center = _webView.center;
}

- (void)createSubviews {
    _webView = [[UIWebView alloc] initWithFrame:self.bounds];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    [_webView.scrollView sizeToFit];
    _webView.scalesPageToFit = YES;
    _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _webView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:_webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = RHProgressViewFrame;
    _progressView.trackTintColor = [UIColor grayColor];
    _progressView.progress = 0.0;
    _progressView.progressTintColor = [UIColor greenColor];
    [_progressView setProgress:0.0f animated:YES];
    [self addSubview:_progressView];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:RHIndicatorViewFrame];
    [_indicatorView setCenter:self.center];
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_indicatorView];
    _indicatorView.hidden = YES;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    _progressView.progressTintColor = progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    _progressView.trackTintColor = trackTintColor;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    [_indicatorView setActivityIndicatorViewStyle:_activityIndicatorViewStyle];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _indicatorView.hidden = NO;
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _progressView.hidden = NO;
    _progressView.progress = 0.0;
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    _progressView.progress = progress;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _progressView.progress = 1.0;
    _progressView.hidden = YES;
    
    [_indicatorView removeFromSuperview];
    
    
    NSString *webViewTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *webViewUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    if (self.webViewDidFinishLoadBlock) {
        self.webViewDidFinishLoadBlock(webViewTitle, webViewUrl);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    _progressView.hidden = YES;
    [_indicatorView removeFromSuperview];
}

@end
