//
//  RHDBModel.h
//  DFCDB
//  需要存入本地数据库的模型的基类
//  需要存入本地数据库的模型继承该基类
//  不需要额外建表,额外写sql语句
//  该层封装了fmdb的建表,sql语句查询
//  实例:DBDemo文件,和UserModel文件
//  主键的名称必须为"code"
//  Created by DaFenQi on 16/11/14.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

// 所有需要本地建表的model全部继承该类

#import <Foundation/Foundation.h>

@interface RHDBModel : NSObject 

// 通过模型的属性自动获取
@property (retain, readonly, nonatomic)NSMutableArray *columnNames; // 表的列名
@property (retain, readonly, nonatomic)NSMutableArray *columnTypes; // 表的列类型

#pragma mark - must be override
// 不需要存储到本地数据库的字段 // 子类必须实现
+ (NSArray *)propertiesNotInTable;
+ (instancetype)dataWithJson:(NSDictionary *)dict;

#pragma mark - 增加数据
// 不清楚到底是保存还是更新时调用该方法
- (BOOL)saveOrUpdate;
// 保存对象
- (BOOL)save;
// 保存多个对象
+ (BOOL)saveObjects:(NSArray *)array;

#pragma mark - 删除数据
// 删除对象
- (BOOL)deleteObject;
// 删除多个对象
+ (BOOL)deleteObjects:(NSArray *)array;
// 清空表
+ (BOOL)clearTable;

/**
 条件删除

 @param statement [UserModel deleteObjectByConditionStatement:@"WHERE primarykey = 2"]

 @return 是否成功
 */
+ (BOOL)deleteObjectByConditionStatement:(NSString *)statement;

/**
 格式化条件删除

 @param format [UserModel deleteObjectByFormat:@"WHERE %@ = %@", @"primarykey" , @"3"]

 @return 是否成功
 */
+ (BOOL)deleteObjectByFormat:(NSString *)format, ...;


#pragma mark - 修改数据
// 更新对象
- (BOOL)update;
// 更新多个对象
+ (BOOL)updateObjects:(NSArray *)array;

#pragma mark - 查找数据
// 查询所有
+ (NSArray *)findAll;
// 主键查询
+ (instancetype)findByPrimaryKey:(NSString *)primaryKey;

/**
 条件查找

 @param statement [UserModel findByConditionStatement:@"WHERE primarykey > 50"]

 @return 模型数组
 */
+ (NSArray *)findByConditionStatement:(NSString *)statement;

/**
 格式化语句条件查找

 @param format [DFCDBModel findByFormat:@"WHERE primarykey > %@", @"50"]

 @return 模型数组
 */
+ (NSArray *)findByFormat:(NSString *)format, ...;

@end
