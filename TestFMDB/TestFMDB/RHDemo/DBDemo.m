//
//  DBDemo.m
//  planByGodWin
//
//  Created by DaFenQi on 16/11/15.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DBDemo.h"
#import "UserModel.h"

@implementation DBDemo


// 为了演示方便采用同步保存数据
// 实际写表应该异步获取
//dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //数据操作
//});

/**
 为了演示方便采用同步保存数据
 实际写表应该异步获取
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
    数据操作
 });
 */
+ (void)demo {
    // 保存一条数据
    for (int i = 0; i < 10; i++) {
        UserModel *user = [UserModel dataWithJson:nil];
        //dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [user save];
        //});
    }

    UserModel *user1 = [UserModel dataWithJson:nil];
    UserModel *user2 = [UserModel dataWithJson:nil];
    UserModel *user3 = [UserModel dataWithJson:nil];
    UserModel *user4 = [UserModel dataWithJson:nil];
    UserModel *user5 = [UserModel dataWithJson:nil];
    UserModel *user6 = [UserModel dataWithJson:nil];

    // 保存多条
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [UserModel saveObjects:@[user1, user2, user3]];
    //});

    // 删除一条
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [user3 deleteObject];
    //});
    
    // 条件删除
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [UserModel deleteObjectByConditionStatement:@"WHERE primarykey = 2"];
    //});
    
    // format条件删除
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [UserModel deleteObjectByFormat:@"WHERE %@ = %@", @"primarykey" , @"3"];
    //});
    
    // 多条删除
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [UserModel deleteObjects:@[user1, user2]];
    //});
    
    // 清空表
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
    // [UserModel clearTable];
    //});
    
    // 修改一条
    user4.nickName = @"何大帅哥";
    [user5 update];
    
    // 修改多条
    user5.nickName = @"何大少";
    user6.nickName = @"何大天才";
    [UserModel updateObjects:@[user5, user6]];
    
    // 查找所有
    NSArray *allUser = [UserModel findAll];
    NSLog(@"allUser = %@", allUser);
    
    // 按主键查找
    UserModel *u = [UserModel findByPrimaryKey:@"1"];
    NSLog(@"u = %@", u);
    
    // 条件查找
    NSArray *allUser1 = [UserModel findByConditionStatement:@"WHERE code = 5"];
    NSLog(@"allUser1 = %@", allUser1);
    
    // format 条件查找
    NSArray *allUser2 = [UserModel findByFormat:@"WHERE code = %@", @"5"];
    NSLog(@"allUser2 = %@", allUser2);
}

@end
