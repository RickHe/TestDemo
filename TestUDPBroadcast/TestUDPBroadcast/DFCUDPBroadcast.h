//
//  DFCUDPBroadcast.h
//  TestUDPBroadcast
//
//  Created by DaFenQi on 2017/5/19.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFCUDPBroadcastDelegate <NSObject>

- (void)udpSocketDidReceiveMessage:(NSString *)message;

@end

@interface DFCUDPBroadcast : NSObject

+ (instancetype)sharedBroadcast;

@property (nonatomic, assign) id<DFCUDPBroadcastDelegate> delegate;

- (void)sendMessage:(NSString *)message;

@end
