//
//  UserModel.m
//  Testttt
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

/**
 *  全能初始化
 *
 *  @param name 姓名
 *  @param age  年龄
 *  @param sex  性别
 *
 *  @return model
 */
- (instancetype)initWithName:(NSString *)name
                         Age:(NSUInteger)age
                         Sex:(UserSex)sex {
    if (self = [super init]) {
        _age = age;
        _name = [name copy];
        _sex = sex;
    }
    return self;
}

/**
 *  便利初始化
 *
 *  @param name 姓名
 *  @param age  年龄
 *  @param sex  性别
 *
 *  @return model
 */
+ (instancetype)userWithName:(NSString *)name
                         Age:(NSUInteger)age
                         Sex:(UserSex)sex {
    return [[[self class] alloc] initWithName:name Age:age Sex:sex];
}

- (id)copyWithZone:(NSZone *)zone {
    return  [[UserModel alloc] initWithName:_name Age:_age Sex:_sex];
}

@end
