//
//  ViewController.m
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/10.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import "RHSafety.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testNSArrayClass];
    [self testNSMutableArrayClass];

    [self testNSDictionaryClass];
    [self testNSMutableDictionaryClass];
    
    [self testNSArray];
    
    [self testNSMutableArray];
    
    [self testNSMutableDictionary];
    
    [self testSafety];
}

- (void)testSafety {
    // 同其他
}

- (void)testNSMutableDictionaryClass {
    for (int i = 0; i < 100; i++) {
        NSMutableDictionary *tmpDic = [NSMutableDictionary new];
        for (int j = 0; j < i; j++) {
            [tmpDic setObject:@(i) forKey:@(i)];
        }
        NSLog(@"%@", NSStringFromClass(tmpDic.class));
    }
    
    id obj = [[NSMutableDictionary alloc] init];
    NSLog(@"%@", NSStringFromClass([obj class]));
    NSLog(@"%@", NSStringFromClass([obj superclass]));
    NSLog(@"----------------end--------------------");
    // NSMutableDictionary 对象的真实类为 __NSDictionaryM
}

- (void)testNSDictionaryClass {
    for (int i = 0; i < 100; i++) {
        NSMutableDictionary *tmpDic = [NSMutableDictionary new];
        for (int j = 0; j < i; j++) {
            [tmpDic setObject:@(i) forKey:@(i)];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:tmpDic];
        NSLog(@"%@", NSStringFromClass(dic.class));
    }
    
    id obj = [[NSDictionary alloc] init];
    NSLog(@"%@", NSStringFromClass([obj class]));
    NSLog(@"%@", NSStringFromClass([obj superclass]));
    NSLog(@"----------------end--------------------");
}

- (void)testNSMutableArrayClass {
    for (int i = 0; i < 100; i++) {
        NSMutableArray *arr = [NSMutableArray new];
        for (int j = 0; j < i; j++) {
            [arr addObject:@(i)];
        }
        id obj = arr[101];
        NSLog(@"%@ %@", NSStringFromClass(arr.class), obj);
    }
    
    id arrI = [[NSMutableArray alloc] init];
    NSLog(@"%@", NSStringFromClass([arrI class]));
    NSLog(@"%@", NSStringFromClass([arrI superclass]));
    NSLog(@"----------------end--------------------");
}

- (void)testNSArrayClass {
    for (int i = 0; i < 100; i++) {
        NSMutableArray *tmpArr = [NSMutableArray new];
        for (int j = 0; j < i; j++) {
            [tmpArr addObject:@(i)];
        }
        NSArray *arr = [NSArray arrayWithArray:tmpArr];
        id obj = arr[101];
        NSLog(@"%@ %@", NSStringFromClass(arr.class), obj);
    }
    
    Class NSArrayI = NSClassFromString(@"__NSArrayI");
    id arrI = [[NSArrayI alloc] init];
    NSLog(@"%@", NSStringFromClass([arrI class]));
    NSLog(@"%@", NSStringFromClass([arrI superclass]));
    NSLog(@"----------------end--------------------");
    //id obj = arrI[0];
    // 由以下代码得出NSArray的实现：是class clusters模式
    // NSArray 作为一个父类接口暴露给使用者，使用者使用不同的创建方法获取到子类的对象
    // NSArray 有三个隐藏子类：__NSArrayI，__NSArray0，__NSSingleObjectArrayI。这三个子类才是我们创建的对象的真正类型
    // 所以我们不能对类似的使用class clusters模式实现的类直接使用[obj isKindOfClass:[NSArray class]]或者[obj isMemberOfClass:[NSArray class]]!
    // 
}

- (void)testNSArray {
    NSArray *arr = @[@"a", @"b"];
    id obj1 = arr[0];
    id obj2 = arr[1];
    id obj3 = arr[2];
    id obj4 = arr[-1];
    NSLog(@"obj1 = %@ obj2 = %@ obj3 = %@ obj4 = %@", obj1, obj2, obj3, obj4);
    
    obj1 = [arr objectAtIndex:0];
    obj2 = [arr objectAtIndex:1];
    obj3 = [arr objectAtIndex:2];
    obj4 = [arr objectAtIndex:-1];
    NSLog(@"obj1 = %@ obj2 = %@ obj3 = %@ obj4 = %@", obj1, obj2, obj3, obj4);

    NSArray *nilArr = nil;
    id obj5 = nilArr[0];
    NSLog(@"obj5 = %@",obj5);
}

- (void)testNSMutableArray {
    NSMutableArray *arr = [@[@"a", @"b"] mutableCopy];
    
    id obj1 = arr[0];
    id obj3 = arr[2];
    id obj4 = arr[-1];
    NSLog(@"obj1 = %@ obj3 = %@ obj4 = %@", obj1, obj3, obj4);
    
    obj1 = [arr objectAtIndex:0];
    obj3 = [arr objectAtIndex:2];
    obj4 = [arr objectAtIndex:-1];
    NSLog(@"obj1 = %@ obj3 = %@ obj4 = %@", obj1, obj3, obj4);

    NSObject *nilObject = nil;
    
    [arr removeObject:nilObject];
    [arr removeObjectAtIndex:100];
    
    [arr replaceObjectAtIndex:100 withObject:nilObject];
    
    [arr addObject:@"ss"];
    [arr addObject:nilObject];
    [arr insertObject:@"adas" atIndex:100];
    [arr insertObject:nilObject atIndex:100];
}

- (void)testNSMutableDictionary {
    NSString *key1 = @"key1";
    NSString *key2 = @"key2";
    NSString *nilKey = nil;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSObject *nilObject = nil;
    [dic setObject:nilObject forKey:key1];
    dic[key2] = nilObject;
    dic[nilKey] = nilObject;
    NSLog(@"value1 = %@ value2 = %@ value3 = %@", dic[key1], dic[key2], dic[nilKey]);
    
    NSObject *object = [NSObject new];
    [dic setObject:object forKey:key1];
    dic[key2] = object;
    dic[nilKey] = object;
    NSLog(@"value1 = %@ value2 = %@ value3 = %@", dic[key1], dic[key2], dic[nilKey]);
    
    NSString *testKey = nil;
    NSString *testValue = nil;
    dic[@"key"] = testValue;
    dic[testKey] = testValue;
}

@end
