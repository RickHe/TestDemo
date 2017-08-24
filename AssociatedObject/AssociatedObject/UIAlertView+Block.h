//
//  UIAlertView+Block.h
//  AssociatedObject
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonIndexBlock)(NSUInteger buttonIndex);

@interface UIAlertView (Block) <UIAlertViewDelegate>

@property (nonatomic, copy) ButtonIndexBlock indexBlock;

/**
 *  初始化
 *
 *  @param indexBlock
 *  @param title             提示
 *  @param message           消息
 *  @param cancelButtonTitle 取消
 *  @param otherButtonTitles 其他
 *
 *  @return alertView
 */
+ (void)alertViewWithBlock:(ButtonIndexBlock)indexBlock
                        Title:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... ;

@end
