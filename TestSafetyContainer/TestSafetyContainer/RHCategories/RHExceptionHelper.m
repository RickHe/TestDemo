//
//  RHExceptionHelper.m
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/10.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import "RHExceptionHelper.h"

@implementation RHExceptionHelper

// 测试的时候抛出异常，发布的时候不影响
+ (void)raiseException:(NSString *)reason {
#if DEBUG
    [[NSException exceptionWithName:reason
                             reason:reason
                           userInfo:nil] raise];
#else
    
#endif
}

@end
