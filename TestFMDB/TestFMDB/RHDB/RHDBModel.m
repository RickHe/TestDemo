//
//  DFCDBModel.m
//  DFCDB
//
//  Created by DaFenQi on 16/11/14.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "RHDBModel.h"
#import <objc/runtime.h>
#import "RHDBHelp.h"

// 数据库支持类型
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"

// 主键
#define kPrimaryKey  @"primarykey"
#define kPrimaryId   @"code"

// 属性
static const NSString *kPropertyNameKey = @"name";
static const NSString *kPropertyTypeKey = @"type";

// 参数
static const NSString *kValuesKey = @"kValuesKey";
static const NSString *kValueStringKey = @"kValueStringKey";
static const NSString *kKeyStringKey = @"kKeyStringKey";

@interface RHDBModel () {
    
}

@end

@implementation RHDBModel

#pragma mark - lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        NSDictionary *dic = [self.class p_setPrimaryKey];
        
        _columnNames = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"name"]];
        _columnTypes = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"type"]];
    }
    return self;
}

+ (instancetype)dataWithJson:(NSDictionary *)dict {
    return nil;
}

#pragma mark - create table
+ (void)initialize {
    if (self != [RHDBModel self]) {
        [self createTable];
    }
}

+ (BOOL)createTable {
    __block BOOL result = NO;
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    
    [dbHelp.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        // 创建表
        NSString *tableName = NSStringFromClass([self class]);
        NSString *columeAndType = [[self class] getColumnAndTypeString];
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,columeAndType];
        
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            result = NO;
            *rollback = YES;
            return;
        };
        
        // 判断表是否增加字段
        NSMutableArray *columns = [NSMutableArray array];
        FMResultSet *resultSet = [db getTableSchema:tableName];
        
        while ([resultSet next]) {
            NSString *column = [resultSet stringForColumn:(NSString *)kPropertyNameKey];
            [columns addObject:column];
        }
        
        NSDictionary *dict = [self.class p_setPrimaryKey];
        NSArray *properties = [dict objectForKey:kPropertyNameKey];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",columns];
        
        // 过滤数组
        NSArray *resultArray = [properties filteredArrayUsingPredicate:filterPredicate];
        // 增添字段
        for (NSString *column in resultArray) {
            
            NSUInteger index = [properties indexOfObject:column];
            NSString *proType = [[dict objectForKey:@"type"] objectAtIndex:index];
            NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",column,proType];
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",NSStringFromClass(self.class),fieldSql];
            
            if (![db executeUpdate:sql]) {
                result = NO;
                *rollback = YES;
                return ;
            }
            
        }
        
    }];
    
    return result;
}

+ (NSString *)getColumnAndTypeString {
    NSMutableString *params = [NSMutableString new];
    
    NSDictionary *dict = [[self class] p_setPrimaryKey];
    NSMutableArray *propertyNames = dict[kPropertyNameKey];
    NSMutableArray *propertyTypes = dict[kPropertyTypeKey];
    
    for (int i = 0; i < propertyNames.count; i++) {
        [params appendFormat:@"%@ %@", propertyNames[i], propertyTypes[i]];
        if(i+1 != propertyNames.count)
        {
            [params appendString:@","];
        }
    }
    
    return params;
}

#pragma mark - data help
+ (BOOL)isSubClass:(NSArray *)array {
    BOOL isSubClass = YES;
    for (id obj in array) {
        if (![obj isKindOfClass:[self class]]) {
            isSubClass = NO;
        }
    }
    
    return isSubClass;
}

+ (NSDictionary *)params:(RHDBModel *)model {
    
    NSMutableString *keyString = [NSMutableString new];
    NSMutableString *valueString = [NSMutableString new];
    NSMutableArray *values = [NSMutableArray new];
    
    for (int i = 0; i < model.columnNames.count; i++) {
        NSString *proname = [model.columnNames objectAtIndex:i];
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        id value = [model valueForKey:proname];
        if (value == nil) {
            value = @"";
        }
        [values addObject:value];
    }
    
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    
    NSDictionary *dict = @{
                           kKeyStringKey : keyString,
                           kValueStringKey : valueString,
                           kValuesKey : values
                           };
    
    return dict;
}

- (NSDictionary *)params {
    
    NSMutableString *keyString = [NSMutableString new];
    NSMutableString *valueString = [NSMutableString new];
    NSMutableArray *values = [NSMutableArray new];
    
    for (int i = 0; i < self.columnNames.count; i++) {
        NSString *proname = [self.columnNames objectAtIndex:i];
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        id value = [self valueForKey:proname];
        if (value == nil) {
            value = @"";
        }
        [values addObject:value];
    }
    
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    
    NSDictionary *dict = @{
                           kKeyStringKey : keyString,
                           kValueStringKey : valueString,
                           kValuesKey : values
                           };
    
    return dict;
}

#pragma mark - data process
#pragma mark - 增加数据
- (BOOL)saveOrUpdate {
    id value = [self.class findByPrimaryKey:[self valueForKey:kPrimaryId]];
    if (value == nil) {
        return [self save];
    } else {
        return [self update];
    }
}

- (BOOL)save {
    id value = [self.class findByPrimaryKey:[self valueForKey:kPrimaryId]];
    if (value != nil) {
        return [self update];
    }
    
    NSString *tableName = NSStringFromClass([self class]);
    
    NSDictionary *dict = [self params];
    NSMutableString *keyString = dict[kKeyStringKey];
    NSMutableString *valueString = dict[kValueStringKey];
    NSMutableArray *insertValues = dict[kValuesKey];
    
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    __block BOOL res = NO;
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
        res = [db executeUpdate:sql withArgumentsInArray:insertValues];
        NSLog(res ? @"插入成功" : @"插入失败");
    }];
    return res;
}

+ (BOOL)saveObjects:(NSArray *)array {
    if (![[self class] isSubClass:array]) {
        return NO;
    }
    
    NSMutableArray *updateArray = [NSMutableArray new];
    NSMutableArray *insertArray = [NSMutableArray new];
    
    for (RHDBModel *model in array) {
        id value = [self.class findByPrimaryKey:[model valueForKey:kPrimaryId]];
        if (value != nil) {
            [updateArray addObject:model];
        } else {
            [insertArray addObject:model];
        }
    }
    
    // 更新数据
    [self.class updateObjects:updateArray];
    
    // 插入数据
    __block BOOL result = NO;
    // 事务
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (RHDBModel *model in insertArray) {
            
            NSString *tableName = NSStringFromClass([self class]);
            
            NSDictionary *dict = [self.class params:model];
            NSMutableString *keyString = dict[kKeyStringKey];
            NSMutableString *valueString = dict[kValueStringKey];
            NSMutableArray *insertValues = dict[kValuesKey];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:insertValues];
            
            NSLog(flag ? @"插入成功" : @"插入失败");
            
            if (!flag) {
                result = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    
    return result;
}

#pragma mark - 删除数据
- (BOOL)deleteObject {
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    __block BOOL result = NO;
    
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:kPrimaryId];
        if (primaryValue == nil) {
            return ;
        }
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,kPrimaryId];
        result = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
        NSLog(result?@"删除成功":@"删除失败");
    }];
    
    return result;
}

+ (BOOL)deleteObjects:(NSArray *)array {
    if (![[self class] isSubClass:array]) {
        return NO;
    }
    
    __block BOOL result = NO;
    
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (RHDBModel *model in array) {
            
            NSString *tableName = NSStringFromClass(self.class);
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,kPrimaryId];
            id value = [model valueForKey:kPrimaryId];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:@[value]];
            
            NSLog(flag?@"删除成功":@"删除失败");
            
            if (!flag) {
                result = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    
    return result;
}

+ (BOOL)deleteObjectByConditionStatement:(NSString *)statement {
    __block BOOL result = NO;
    
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@", tableName, statement];
        result = [db executeUpdate:sql];
        NSLog(result ? @"删除成功" : @"删除失败");
    }];
    
    return result;
}

+ (BOOL)deleteObjectByFormat:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);
    NSString *statement = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    
    return [self.class deleteObjectByConditionStatement:statement];
}

+ (BOOL)clearTable {
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    __block BOOL result = NO;
    
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
        result = [db executeUpdate:sql];
        NSLog(result?@"清空成功":@"清空失败");
    }];
    
    return result;
}

#pragma mark - 修改数据
- (BOOL)update {
    __block BOOL result = NO;
    
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        
        id primartKey = [self valueForKey:kPrimaryId];
        if (primartKey == nil) {
            return ;
        }
        
        NSMutableString *keyString = [NSMutableString new];
        NSMutableArray *updateValues = [NSMutableArray new];
        
        for (int i = 0; i < self.columnNames.count; i++) {
            NSString *propertyName = self.columnNames[i];
            if ([propertyName isEqualToString:kPrimaryId]) {
                continue;
            }
            
            [keyString appendFormat:@" %@=?,", propertyName];
            id value = [self valueForKey:propertyName];
            if (value == nil) {
                value = @"";
            }
            
            [updateValues addObject:value];
        }
        
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
        
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?;", tableName, keyString, kPrimaryId];
        [updateValues addObject:primartKey];
        
        result = [db executeUpdate:sql withArgumentsInArray:updateValues];
        NSLog(result ? @"更新成功" : @"更新失败");
    }];
    
    return result;
}

+ (BOOL)updateObjects:(NSArray *)array {
    if (![[self class] isSubClass:array]) {
        return NO;
    }
    
    __block BOOL result = NO;
    
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (RHDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            
            id primaryValue = [model valueForKey:kPrimaryId];
            if (primaryValue == nil) {
                result = NO;
                *rollback = YES;
                return;
            }
            
            NSMutableString *keyString = [NSMutableString string];
            NSMutableArray *updateValues = [NSMutableArray  array];
            
            for (int i = 0; i < model.columnNames.count; i++) {
                NSString *proname = [model.columnNames objectAtIndex:i];
                if ([proname isEqualToString:kPrimaryId]) {
                    continue;
                }
                
                [keyString appendFormat:@" %@=?,", proname];
                
                id value = [model valueForKey:proname];
                if (value == nil) {
                    value = @"";
                }
                
                [updateValues addObject:value];
            }
            
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@=?;", tableName, keyString, kPrimaryId];
            [updateValues addObject:primaryValue];
            
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:updateValues];
            
            NSLog(flag ? @"更新成功" : @"更新失败");
            
            if (!flag) {
                result = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    
    return result;
}

#pragma mark - 查找数据
+ (NSArray *)findAll {
    return [self.class findByConditionStatement:@""];
}

+ (instancetype)findByPrimaryKey:(NSString *)primaryKey {
    
    NSString *statement = [NSString stringWithFormat:@"WHERE %@ = '%@'", kPrimaryId ,primaryKey];
    
    NSArray *results = [self.class findByConditionStatement:statement];
    
    if (results.count >= 1) {
        return [results firstObject];
    } else {
        return nil;
    }
}

+ (NSArray *)findByConditionStatement:(NSString *)statement {
    NSMutableArray *results = [NSMutableArray new];
    RHDBHelp *dbHelp = [RHDBHelp sharedInstance];
    [dbHelp.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@", tableName, statement];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            RHDBModel *model = [[self.class alloc] init];
            for (int i = 0; i < model.columnNames.count; i++) {
                NSString *columnName = model.columnNames[i];
                NSString *columnType = model.columnTypes[i];
                
                if ([columnType isEqualToString:SQLINTEGER]) {
                    [model setValue:[NSNumber numberWithLongLong:[resultSet longLongIntForColumn:columnName]] forKey:columnName];
                } else if ([columnType isEqualToString:SQLBLOB]) {
                    [model setValue:[resultSet dataForColumn:columnName] forKey:columnName];
                } else if ([columnType isEqualToString:SQLREAL]) {
                    [model setValue:[NSNumber numberWithDouble:[resultSet doubleForColumn:columnName]] forKey:columnName];
                } else {
                    [model setValue:[resultSet stringForColumn:columnName] forKey:columnName];
                }
                
            }
            
            [results addObject:model];
            FMDBRelease(model);
        }
    }];
    
    return results;
}

+ (NSArray *)findByFormat:(NSString *)format, ... {
    va_list list;
    va_start(list, format);
    NSString *statement = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:list];
    va_end(list);
    
    return [self.class findByConditionStatement:statement];
}

#pragma mark - private

/**
 获取所有属性的名字类型,不包括主键
 
 @return 字典存属性名字,类型
 */
+ (NSDictionary *)p_getProperties {
    NSMutableArray *propertyNames = [NSMutableArray new];
    NSMutableArray *propertyTypes = [NSMutableArray new];
    // 不需要的字段
    NSArray *propertiesNotInTable = [[self class] propertiesNotInTable];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        // 属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([propertiesNotInTable containsObject:propertyName]) {
            continue;
        }
        
        [propertyNames addObject:propertyName];
        
        // 属性类型
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyType hasPrefix:@"T@\"NSString\""]) {
            [propertyTypes addObject:SQLTEXT];
        } else if ([propertyType hasPrefix:@"T@\"NSData\""]) {
            [propertyTypes addObject:SQLBLOB];
        } else if ([propertyType hasPrefix:@"Ti"] ||
                   [propertyType hasPrefix:@"TI"] ||
                   [propertyType hasPrefix:@"Ts"] ||
                   [propertyType hasPrefix:@"TS"] ||
                   [propertyType hasPrefix:@"TB"] ||
                   [propertyType hasPrefix:@"Tq"] ||
                   [propertyType hasPrefix:@"TQ"]) {
            [propertyTypes addObject:SQLINTEGER];
        } else {
            [propertyTypes addObject:SQLREAL];
        }
        
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:propertyNames, kPropertyNameKey, propertyTypes, kPropertyTypeKey, nil];
    
}

/**
 获取所有属性的名字类型,设置主键
 
 @return 字典存属性名字,类型
 */
+ (NSDictionary *)p_setPrimaryKey {
    NSDictionary *dict = [[self class] p_getProperties];
    NSMutableArray *propertyNames = dict[kPropertyNameKey];
    NSMutableArray *propertyTypes = dict[kPropertyTypeKey];
    // 设置主键
    for (int i = 0; i < propertyNames.count; i++) {
        id obj = propertyNames[i];
        if ([obj isEqualToString:@"code"]) {
            id objType = propertyTypes[i];
            propertyTypes[i] = [NSString stringWithFormat:@"%@ %@", objType, kPrimaryKey];
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:propertyNames, kPropertyNameKey, propertyTypes, kPropertyTypeKey, nil];
}

#pragma mark - others
// 不需要存储到本地数据库的字段 // 子类必须实现
+ (NSArray *)propertiesNotInTable {
    return nil;
}

- (NSString *)description {
    NSString *result = @"";
    NSDictionary *dict = [self.class p_setPrimaryKey];
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    
    for (int i = 0; i < proNames.count; i++) {
        NSString *proName = [proNames objectAtIndex:i];
        id  proValue = [self valueForKey:proName];
        result = [result stringByAppendingFormat:@"%@:%@\n",proName,proValue];
    }
    
    return result;
}

@end
