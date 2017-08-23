//
//  UserModel.h
//  Testttt
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户性别
typedef NS_ENUM(NSUInteger, UserSex) {
    UserSexMan,
    UserSexWomen,
    UserSexUnknow,
};

@interface UserModel : NSObject <NSCopying>

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) NSUInteger age;
@property (nonatomic, readonly, assign) UserSex sex;
@property (nonatomic, copy) NSString *nick;

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
                         Sex:(UserSex)sex;
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
                         Sex:(UserSex)sex;

@end
