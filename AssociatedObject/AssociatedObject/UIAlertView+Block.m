//
//  UIAlertView+Block.m
//  AssociatedObject
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@implementation UIAlertView (Block) 

static void *const kIndexBlock = "kIndexBlock";

+ (void)alertViewWithBlock:(ButtonIndexBlock)indexBlock
                             Title:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    va_list args;
    if(otherButtonTitles) {
        va_start(args, otherButtonTitles);
        [alert addButtonWithTitle:otherButtonTitles];
        while ((otherButtonTitles = va_arg(args, NSString *))) {
            [alert addButtonWithTitle:otherButtonTitles];
        }
        va_end(args);
    }
    alert.delegate = alert;
    alert.indexBlock = indexBlock;
    [alert show];
}

/**
 *  block回掉
 *
 *  @param alertView   alert
 *  @param buttonIndex 按钮的buttonindex
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ButtonIndexBlock block = [self indexBlock];
    if (block) {
        block(buttonIndex);
    }   
}

/**
 *  设置关联对象
 *
 *  @param indexBlock 设置值
 */
- (void)setIndexBlock:(ButtonIndexBlock)indexBlock {
    objc_setAssociatedObject(self, kIndexBlock, indexBlock, OBJC_ASSOCIATION_COPY);
}

/**
 *  获取关联对象
 *
 *  @return 获取对象值
 */
- (ButtonIndexBlock)indexBlock {
    return objc_getAssociatedObject(self, kIndexBlock);
}

/**
 *  移除关联对象 
 *  不知道是否必要???
 */
- (void)dealloc {
    objc_removeAssociatedObjects(self);
}

@end
