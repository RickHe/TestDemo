//
//  RHDBHelp.h
//  DFCDB
//  数据库建库等初始化
//  Created by DaFenQi on 16/11/14.
//  Copyright © 2016年 DaFenQi. All rights reserved.

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface RHDBHelp : NSObject

// 线程安全
@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

/**
 单例,直接使用,内部会帮助创建本地数据库

 @return 单例
 */
+ (RHDBHelp *)sharedInstance;

/**
 返回本地数据库路径

 @return 数据库路径
 */
+ (NSString *)dbPath;

@end
