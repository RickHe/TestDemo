//
//  DFCUDPBroadcast.m
//  TestUDPBroadcast
//
//  Created by DaFenQi on 2017/5/19.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "DFCUDPBroadcast.h"
#import "GCDAsyncUdpSocket.h"

static NSString *kHost = @"255.255.255.255";
static NSUInteger kPort = 22360;
static NSInteger kTimeOutInterval = -1;

@interface DFCUDPBroadcast () <GCDAsyncUdpSocketDelegate>

@property (nonatomic, strong) GCDAsyncUdpSocket *udpSocket;
@property (nonatomic, strong) dispatch_queue_t delegateQueue;

@end

@implementation DFCUDPBroadcast

static DFCUDPBroadcast *_sharedBroadcast;

+ (instancetype)sharedBroadcast {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedBroadcast = [[DFCUDPBroadcast alloc] init];
    });
    
    return _sharedBroadcast;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegateQueue = dispatch_queue_create("udpDelegateQueue", DISPATCH_QUEUE_SERIAL);
        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                                   delegateQueue:_delegateQueue
                                                     socketQueue:NULL];
        
        NSError *error = nil;

        if ([_udpSocket bindToPort:kPort error:&error]) {
            NSLog(@"bindToPort success");
        } else {
            NSLog(@"bindToPort error = %@", error);
        }
        
        if ([_udpSocket enableBroadcast:YES error:&error]) {
            NSLog(@"enableBroadcast success");
        } else {
            NSLog(@"enableBroadcast error = %@", error);
        }
        
        if ([_udpSocket beginReceiving:&error]) {
            NSLog(@"beginReceiving success");
        } else {
            NSLog(@"beginReceiving error = %@", error);
        }
    }
    return self;
}

- (void)sendMessage:(NSString *)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.udpSocket sendData:data
                      toHost:kHost
                        port:kPort
                 withTimeout:kTimeOutInterval
                         tag:0];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock
   didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext {
    NSString * message = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
    
    NSLog(@"receive from ip:%@ port:%i", [GCDAsyncUdpSocket hostFromAddress:address], [GCDAsyncUdpSocket portFromAddress:address]);
    
    // 协议  收到数据后 将收到的数据返回回去使用
    if ([self.delegate respondsToSelector:@selector(udpSocketDidReceiveMessage:)]) {
        [self.delegate udpSocketDidReceiveMessage:message];
    }
    
    [self.udpSocket receiveOnce:nil];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"error = %@", error);
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"error = %@", error);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"%s", __func__);
    NSLog(@"tag = %li", tag);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"%s", __func__);
    NSLog(@"connect to ip:%@ port:%i", [GCDAsyncUdpSocket hostFromAddress:address], [GCDAsyncUdpSocket portFromAddress:address]);
}

@end
