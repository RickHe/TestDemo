//
//  RHSendMessageViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHSendMessageViewController.h"
#import <MessageUI/MessageUI.h>

@interface RHSendMessageViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation RHSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)sendMessageAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            // 打开 message 发送
            NSURL *url = [NSURL URLWithString:@"sms://10086"];
            [self openUrl:url];
            break;
        }
        case 2: {
            // MessageUI 内部发送短信
            MFMessageComposeViewController *composeVC = [[MFMessageComposeViewController alloc] init];
            composeVC.body = @"套餐";
            composeVC.recipients = @[@"10086"];
            composeVC.messageComposeDelegate = self;
            [self presentViewController:composeVC animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        default:
            break;
    }
}

@end
