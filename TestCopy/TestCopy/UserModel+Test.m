//
//  UserModel+Test.m
//  Testttt
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "UserModel+Test.h"
#import <objc/runtime.h>

@implementation UserModel (Test)

static void const *kTestKey = @"kTestKey";

- (void)setTest:(NSString *)test {
    objc_setAssociatedObject(self, kTestKey, test, OBJC_ASSOCIATION_COPY);
}

- (NSString *)test {
    return objc_getAssociatedObject(self, kTestKey);
}

- (void)dealloc {
    objc_removeAssociatedObjects(self);
}

@end
