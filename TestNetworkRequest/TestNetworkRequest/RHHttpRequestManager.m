//
//  RHHttpRequestManager.m
//  TestNetworkRequest
//
//  Created by DaFenQI on 2017/10/18.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHHttpRequestManager.h"

typedef NS_ENUM(NSUInteger, kSeverDevelopmentEnvironmentType) {
    kSeverDevelopmentEnvironmentTypeDevelop = 1,
    kSeverDevelopmentEnvironmentTypeBeta,
    kSeverDevelopmentEnvironmentTypeRelease,
};

#define kCommonTimeoutInterval 20

#define kSeverDevelopmentEnvironment 1

// 开发环境
#if  kSeverDevelopmentEnvironment == kSeverDevelopmentEnvironmentTypeDevelop

#define BASE_API_URL @"http://192.168.2.74/v1/"

// 测试环境
#elif kSeverDevelopmentEnvironment == kSeverDevelopmentEnvironmentTypeBeta

#define BASE_API_URL @"http://192.168.2.74/v1/"

// 发布环境
#elif kSeverDevelopmentEnvironment == kSeverDevelopmentEnvironmentTypeRelease

#define BASE_API_URL @"http://192.168.2.74/v1/"

// 其他
#else

#define BASE_API_URL @"http://192.168.2.74/v1/"

#endif

#import "AFNetworking.h"

@interface RHHttpRequestManager ()

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation RHHttpRequestManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static RHHttpRequestManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

-(AFHTTPSessionManager*)manager{
    if (!_manager) {
        NSString *url = [self baseUrl];
        
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                              @"text/plain",
                                                              @"text/javascript",
                                                              @"text/json",
                                                              @"text/html",
                                                              nil];
        _manager.requestSerializer.timeoutInterval = kCommonTimeoutInterval;
        //_manager.securityPolicy = [self pathsecurityPolicy];
        _manager.securityPolicy.allowInvalidCertificates = YES;
    }
    return _manager;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [[self class] sharedManager];
}

- (NSURLSessionDataTask *)postRequestWithPath:(NSString *)path
                                      success:(kRHRequestSuccessBlock)success
                                      failure:(kRHRequestFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary new];
    return [self postRequestWithPath:path
                              params:params
                             success:success
                             failure:failure];
}


- (NSURLSessionDataTask *)postRequestWithPath:(NSString *)path
                                       params:(NSMutableDictionary *)params
                                      success:(kRHRequestSuccessBlock)success
                                      failure:(kRHRequestFailureBlock)failure {
    [self setCommonParams:params];
    
    return [[self manager] POST:path
                     parameters:params
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            if ([self isReturnRightValue:responseObject]) {
                                if (success) {
                                    success(responseObject);
                                }
                            } else {
                                if (failure) {
                                    failure(responseObject);
                                }
                            }
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSString *errStr = [self errorString:error];
                            if (failure) {
                                failure(errStr);
                            }
                        }];
}

- (NSURLSessionDataTask *)getRequestWithPath:(NSString *)path
                                     success:(kRHRequestSuccessBlock)success
                                     failure:(kRHRequestFailureBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary new];
    return [self getRequestWithPath:path
                             params:params
                            success:success
                            failure:failure];
}

- (NSURLSessionDataTask *)getRequestWithPath:(NSString *)path
                                      params:(NSMutableDictionary *)params
                                     success:(kRHRequestSuccessBlock)success
                                     failure:(kRHRequestFailureBlock)failure {
    [self setCommonParams:params];
    
    return [[self manager]  GET:path
                     parameters:params
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            if ([self isReturnRightValue:responseObject]) {
                                if (success) {
                                    success(responseObject);
                                }
                            } else {
                                if (failure) {
                                    failure(responseObject);
                                }
                            }
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSString *errStr = [self errorString:error];
                            if (failure) {
                                failure(errStr);
                            }
                        }];
}

- (NSURLSessionDataTask *)uploadFile:(NSString *)filePath
                              params:(NSMutableDictionary *)params
                              method:(NSString *)method
                            progress:(kRHRequestProgressBlock)progress
                             success:(kRHRequestSuccessBlock)success
                             failure:(kRHRequestFailureBlock)failure {
    [self setCommonParams:params];
    
    NSString *fileName = [[filePath componentsSeparatedByString:@"/"] lastObject];
    
    return [[self manager] POST:filePath
              parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [formData appendPartWithFileData:data
                                name:@"file"
                            fileName:fileName
                            mimeType:[self mimeType:fileName]];
}
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    if (progress) {
                        progress(uploadProgress.fractionCompleted);
                    }
                }
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     if ([self isReturnRightValue:responseObject]) {
                         if (success) {
                             success(responseObject);
                         }
                     } else {
                         if (failure) {
                             failure(responseObject);
                         }
                     }
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSString *errStr = [self errorString:error];
                     if (failure) {
                         failure(errStr);
                     }
                 }];
}

- (void)cancelAllRequests {
    [[self manager].operationQueue cancelAllOperations];
}

#pragma mark - common
// https
-(AFSecurityPolicy*)securityPolicy{
    // 服务器生成的证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setPinnedCertificates:certSet];
    [securityPolicy setValidatesDomainName:NO];
    
    return securityPolicy;
}

- (NSString *)baseUrl{
    return BASE_API_URL;
}

- (void)setCommonParams:(NSMutableDictionary *)parameters{
    
}

- (NSString *)errorString:(NSError *)error{
    NSString *msg = @"网络异常,请检查网络";
    if (error.code == NSURLErrorTimedOut) {
        msg = @"请求超时,请检查网络";
    }
    else if (error.code == NSURLErrorCannotConnectToHost || error.code == NSURLErrorNotConnectedToInternet) {
        msg = @"网络未开启,请检查网络";
    }else if([error code] == NSURLErrorCancelled){
        msg = @"请检查网络,已经取消";
    }
    
    return msg;
}

- (BOOL)isReturnRightValue:(NSDictionary *)responseObject {
    // 根据公司的规范，来判断数据是否返回成功
    // 若成功回调 successBlock，否则回调 failureBlock
    BOOL success = NO;
    
    id resultCode = [responseObject objectForKey:@"resultCode"];
    if (!resultCode) {
        return success;
    }
    
    NSInteger code = [resultCode integerValue];
    
    if (code == 0) {
        success = YES;
    } else{
        success = NO;
    }
    
    return success;
}

-(NSString *)mimeType:(NSString *)fileName{
    NSString *mimeType = nil;
    
    // 最常用的放最前面
    if ([fileName hasSuffix:@"jpg"]) {
        mimeType = @"image/jpg";
    } else if ([fileName hasSuffix:@"jpeg"]) {
        mimeType = @"image/jpeg";
    } else if ([fileName hasSuffix:@"png"]) {
        mimeType = @"image/png";
    } else if ([fileName hasSuffix:@"mov"]) {
        mimeType = @"image/mov";
    } else if ([fileName hasSuffix:@"gif"]) {
        mimeType = @"image/gif";
    }
    
    return mimeType;
}

@end
