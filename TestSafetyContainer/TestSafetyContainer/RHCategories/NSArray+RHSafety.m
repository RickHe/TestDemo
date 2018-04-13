//
//  NSArray+RHSafety.m
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/10.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import "NSArray+RHSafety.h"
#import <objc/runtime.h>
#import "RHExceptionHelper.h"

@implementation NSArray (RHSafety)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzlingMethod];
    });
}

+ (void)swizzlingMethod {
    // __NSArrayI，__NSArray0，__NSSingleObjectArrayI
    [self swizzlingClass:NSClassFromString(@"__NSArray0")
                selector:@selector(objectAtIndex:)
            destSelector:@selector(rh_0objectAtIndex:)];
    [self swizzlingClass:NSClassFromString(@"__NSArray0")
                selector:@selector(objectAtIndexedSubscript:)
            destSelector:@selector(rh_0objectAtIndexedSubscript:)];
    
    [self swizzlingClass:NSClassFromString(@"__NSArrayI")
                selector:@selector(objectAtIndex:)
            destSelector:@selector(rh_1objectAtIndex:)];
    [self swizzlingClass:NSClassFromString(@"__NSArrayI")
                selector:@selector(objectAtIndexedSubscript:)
            destSelector:@selector(rh_1objectAtIndexedSubscript:)];
    
    [self swizzlingClass:NSClassFromString(@"__NSSingleObjectArrayI")
                selector:@selector(objectAtIndex:)
            destSelector:@selector(rh_IobjectAtIndex:)];
    [self swizzlingClass:NSClassFromString(@"__NSSingleObjectArrayI")
                selector:@selector(objectAtIndexedSubscript:)
            destSelector:@selector(rh_IobjectAtIndexedSubscript:)];
}

+ (void)swizzlingClass:(Class)class
              selector:(SEL)selector
          destSelector:(SEL)destSelector {
    Method originMethod = class_getInstanceMethod(class, selector);
    Method destMethod = class_getInstanceMethod(class, destSelector);
    method_exchangeImplementations(originMethod, destMethod);
}

- (id)rh_0objectAtIndexedSubscript:(NSUInteger)idx {
    if (self.count <= idx) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_0objectAtIndexedSubscript:idx];
    }
}

- (id)rh_0objectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_0objectAtIndex:index];
    }
}

- (id)rh_1objectAtIndexedSubscript:(NSUInteger)idx {
    if (self.count <= idx) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_1objectAtIndexedSubscript:idx];
    }
}

- (id)rh_1objectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_1objectAtIndex:index];
    }
}

- (id)rh_IobjectAtIndexedSubscript:(NSUInteger)idx {
    if (self.count <= idx) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_IobjectAtIndexedSubscript:idx];
    }
}

- (id)rh_IobjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        [RHExceptionHelper raiseException:@"index beyond array count"];
        return nil;
    } else {
        return [self rh_IobjectAtIndex:index];
    }
}

@end
