//
//  ViewController.m
//  加密
//
//  Created by hmy2015 on 16/5/26.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", [self base64Encoding:@"hello world"]);
    NSLog(@"%@", [self base64Encoding:@"hello"]);
    NSLog(@"%@", [self md5:@"hello world"]);
    NSLog(@"%@", [self md5_1:@"hello world"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  base 64 加密
 *
 *  @param original 要加密的字符串
 *
 *  @return 加密后的字符串
 */
- (NSString *)base64Encoding:(NSString *)original {
    NSData *data = [original dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

/**
 *  md5 加密
 *
 *  @param original 要加密的字符串
 *
 *  @return 加密后的字符串
 */

- (NSString *)md5:(NSString *)original {
    const char *str = [original UTF8String];
    unsigned char result[16];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *tempMutableStr = [NSMutableString new];
    for (int i = 0; i < 16; i++) {
        [tempMutableStr appendFormat:@"%02x", result[i]];
    }
    return [NSString stringWithFormat:@"%@", tempMutableStr];
}

- (NSString *)md5_1:(NSString *)original {
    const void *cStr = [original UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
