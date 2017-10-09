//
//  RHWebView.h
//  TestWebView
//
//  Created by DaFenQI on 2017/9/29.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RHWebViewDidFinishLoadBlock)(NSString *webViewTitle, NSString *webViewUrl);

@interface RHWebView : UIView

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property(nonatomic, copy) RHWebViewDidFinishLoadBlock webViewDidFinishLoadBlock;

@end
