//
//  UserModel+Test.h
//  Testttt
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "UserModel.h"

@interface UserModel (Test)

// 只会生成设置方法和获取方法的声明,不生成属性
@property (nonatomic, copy) NSString *test;

@end
