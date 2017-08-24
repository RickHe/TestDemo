//
//  DynamicBinding.m
//  AssociatedObject
//
//  Created by hemiying on 15/12/24.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "DynamicBinding.h"
#import <objc/runtime.h>

@interface DynamicBinding ()

@property (nonatomic, strong) NSMutableDictionary *autoDictionary;

@end

@implementation DynamicBinding

@dynamic test;
@dynamic test1;
@dynamic test2;
@dynamic test3;



- (instancetype)init {
    if (self = [super init]) {
        _autoDictionary = [NSMutableDictionary new];
    }
    return self;
}

/**
 *  添加动态方法
 *
 *  @param sel 编译时候未找到的方法名称
 *
 *  @return 是否动态添加方法
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectString = NSStringFromSelector(sel);
    if ([selectString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

/**
 *  动态添加获取方法
 *
 *  @param self 对象
 *  @param _cmd 方法名称
 *
 *  @return 返回获取值
 */
id autoDictionaryGetter(id self, SEL _cmd) {
    NSString *selectName = NSStringFromSelector(_cmd);
    DynamicBinding *typedSelf = (DynamicBinding *)self;
    return typedSelf.autoDictionary[selectName];
}

/**
 *  动态添加设置方法
 *
 *  @param self  对象
 *  @param _cmd  方法名
 *  @param value 设置参数
 */
void autoDictionarySetter(id self, SEL _cmd, id value) {
    DynamicBinding *typedSelf = (DynamicBinding *)self;
    // 函数名称
    NSString *selectName = NSStringFromSelector(_cmd);
    // 函数名去称掉set
    NSString *name = [selectName substringFromIndex:3];
    // 函数名去称掉set后在去掉:
    NSString *subName = [name substringToIndex:name.length - 1];
    // 首字母转小写
    NSString *firstString = [[subName substringToIndex:1] lowercaseString];
    // 用小写字母替换首字母得到key
    NSString *key = [subName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    if (value) {
         typedSelf.autoDictionary[key] = value;
    } else {
        [typedSelf.autoDictionary removeObjectForKey:key];
    }
}

@end
