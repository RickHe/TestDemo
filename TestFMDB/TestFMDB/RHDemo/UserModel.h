//
//  UserModel.h
//  planByGodWin
//  演示用法
//  Created by DaFenQi on 16/11/15.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "RHDBModel.h"

@interface UserModel : RHDBModel

/*
 用户的详细资料包括（不限于）：
 用户编号（教师编号/学生编号）、年级、班级、用户昵称、头像地址、性别、出生日期和密码（可选）等
 */

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *userCode;
@property (nonatomic, copy) NSString *classCode;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthdate;

// 必须实现
+ (NSArray *)propertiesNotInTable;
+ (instancetype)dataWithJson:(NSDictionary *)dict;

@end
