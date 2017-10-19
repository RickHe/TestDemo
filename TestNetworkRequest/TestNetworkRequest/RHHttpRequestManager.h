//
//  RHHttpRequestManager.h
//  TestNetworkRequest
//
//  Created by DaFenQI on 2017/10/18.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef void (^kRHRequestSuccessBlock)(id obj);
typedef void (^kRHRequestFailureBlock)(id obj);
typedef void (^kRHRequestProgressBlock)(CGFloat progresss);

@interface RHHttpRequestManager : NSObject

+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)postRequestWithPath:(NSString *)path
                                      success:(kRHRequestSuccessBlock)success
                                      failure:(kRHRequestFailureBlock)failure;
- (NSURLSessionDataTask *)postRequestWithPath:(NSString *)path
                                       params:(NSMutableDictionary *)params
                                      success:(kRHRequestSuccessBlock)success
                                      failure:(kRHRequestFailureBlock)failure;

- (NSURLSessionDataTask *)getRequestWithPath:(NSString *)path
                                     success:(kRHRequestSuccessBlock)success
                                     failure:(kRHRequestFailureBlock)failure;
- (NSURLSessionDataTask *)getRequestWithPath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                     success:(kRHRequestSuccessBlock)success
                                     failure:(kRHRequestFailureBlock)failure;

- (NSURLSessionDataTask *)uploadFile:(NSString *)filePath
                              params:(NSMutableDictionary *)params
                              method:(NSString *)method
                            progress:(kRHRequestProgressBlock)progress
                             success:(kRHRequestSuccessBlock)success
                             failure:(kRHRequestFailureBlock)failure;

// 取消所有任务， 取消一个任务，[datatask cancel]
- (void)cancelAllRequests;


@end
