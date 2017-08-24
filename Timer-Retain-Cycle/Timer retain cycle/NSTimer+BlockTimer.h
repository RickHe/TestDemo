//
//  NSTimer+BlockTimer.h
//  Timer retain cycle
//
//  Created by hmy2015 on 16/8/28.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HMYTimerBlock)();

@interface NSTimer (BlockTimer)

+ (NSTimer *)HMYScheduledTimerWithTimeInterval:(NSTimeInterval)timerInterval
                                    repeats:(BOOL)yesOrNo
                                 timerBlock:(HMYTimerBlock)timerBlock;

@end
