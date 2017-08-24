//
//  NSTimer+BlockTimer.m
//  Timer retain cycle
//
//  Created by hmy2015 on 16/8/28.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "NSTimer+BlockTimer.h"

@implementation NSTimer (BlockTimer)

+ (NSTimer *)HMYScheduledTimerWithTimeInterval:(NSTimeInterval)timerInterval
                                    repeats:(BOOL)yesOrNo
                                 timerBlock:(HMYTimerBlock)timerBlock {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                                      target:self
                                                    selector:@selector(timerAction:)
                                                    userInfo:timerBlock
                                                     repeats:yesOrNo];
    return timer;
}

+ (void)timerAction:(NSTimer *)timer {
    HMYTimerBlock timerBlock = timer.userInfo;
    if (timerBlock) {
        timerBlock();
    }
}

@end
