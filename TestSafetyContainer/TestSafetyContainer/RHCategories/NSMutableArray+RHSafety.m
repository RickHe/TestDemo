//
//  NSMutableArray+RHSafety.m
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/10.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import "NSMutableArray+RHSafety.h"
#import <objc/runtime.h>
#import "RHExceptionHelper.h"

@implementation NSMutableArray (RHSafety)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzlingMethod];
    });
}

+ (void)swizzlingMethod {
    [self swizzlingSelector:@selector(objectAtIndexedSubscript:) destSelector:@selector(rh_objectAtIndexedSubscript:)];
    [self swizzlingSelector:@selector(objectAtIndex:) destSelector:@selector(rh_objectAtIndex:)];
    
    [self swizzlingSelector:@selector(addObject:) destSelector:@selector(rh_addObject:)];
    [self swizzlingSelector:@selector(insertObject:atIndex:) destSelector:@selector(rh_insertObject:atIndex:)];
    
    [self swizzlingSelector:@selector(removeObject:) destSelector:@selector(rh_removeObject:)];
    [self swizzlingSelector:@selector(removeObjectAtIndex:) destSelector:@selector(rh_removeObjectAtIndex:)];
    
    [self swizzlingSelector:@selector(replaceObjectAtIndex:withObject:) destSelector:@selector(rh_replaceObjectAtIndex:withObject:)];
}

+ (void)swizzlingSelector:(SEL)selector destSelector:(SEL)destSelector {
    Class class = NSClassFromString(@"__NSArrayM");
    Method originMethod = class_getInstanceMethod(class, selector);
    Method destMethod = class_getInstanceMethod(class, destSelector);
    method_exchangeImplementations(originMethod, destMethod);
}

- (id)rh_objectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_objectAtIndex:index];
    }
}

- (id)rh_objectAtIndexedSubscript:(NSUInteger)idx {
    if (self.count <= idx) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_objectAtIndexedSubscript:idx];
    }
}

- (void)rh_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        if (index > self.count) {
            index = self.count;
        }
        [self rh_insertObject:anObject atIndex:index];
    }
}

- (void)rh_addObject:(id)anObject {
    if (anObject) {
        [self rh_addObject:anObject];
    }
}

- (void)rh_removeObject:(id)anObject {
    if (anObject && [self containsObject:anObject]) {
        [self rh_removeObject:anObject];
    }
}

- (void)rh_removeObjectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        [self rh_removeObjectAtIndex:index];
    } else {
        [RHExceptionHelper raiseException:@"index beyond array count"];
    }
}

- (void)rh_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && self.count > index) {
        [self rh_replaceObjectAtIndex:index withObject:anObject];
    }
}

@end
