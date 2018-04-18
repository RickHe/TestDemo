//
//  UserModel.m
//  planByGodWin
//
//  Created by DaFenQi on 16/11/15.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSArray *)propertiesNotInTable {
    return nil;
}

+ (instancetype)dataWithJson:(NSDictionary *)dict {
    // test
    static int i = 0;
    i++;
    UserModel *model = [[UserModel alloc] init];
    model.code = [NSString stringWithFormat:@"%i", i];
    model.userCode = @"121";
    model.classCode = @"242";
    model.nickName = [NSString stringWithFormat:@"rick %i", i];
    model.imageUrl = @"http://www.baidu.com";
    model.sex = @"男";
    model.birthdate = @"1995.01.25";
    
    return model;
}

@end
