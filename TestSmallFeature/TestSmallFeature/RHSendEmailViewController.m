//
//  RHSendEmailViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHSendEmailViewController.h"
#import <MessageUI/MessageUI.h>

@interface RHSendEmailViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation RHSendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 打开自带的 mail 应用发送
    NSURL *url = [NSURL URLWithString:@"mailto://1292711060@qq.com"];
    [self openUrl:url];
    
    // MessageUI 内部发送mail
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
    if (composeVC == nil) {
        NSLog(@"尚未登录邮箱");
        return;
    }
    //composeVC.body = @"套餐";
    [composeVC setToRecipients:@[@"1292711060@qq.com"]];
    [composeVC setSubject:@"主题"];
    [composeVC setMessageBody:@"这是一封测试邮件" isHTML:NO];
    composeVC.mailComposeDelegate = self;
    
    UIImage *image = [UIImage imageNamed:@"0.jpg"];
    [composeVC addAttachmentData:UIImageJPEGRepresentation(image, 0.6) mimeType:@"" fileName:@"123.jpg"];
    
    [self presentViewController:composeVC animated:YES completion:nil];
}

- (IBAction)sendEmailAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            // 打开自带的 mail 应用发送
            NSURL *url = [NSURL URLWithString:@"mailto://1292711060@qq.com"];
            [self openUrl:url];
            break;
        }
        case 2: {
            // MessageUI 内部发送mail
            MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
            if (composeVC == nil) {
                NSLog(@"尚未登录邮箱");
                return;
            }
            //composeVC.body = @"套餐";
            [composeVC setToRecipients:@[@"1292711060@qq.com"]];
            [composeVC setSubject:@"主题"];
            [composeVC setMessageBody:@"这是一封测试邮件" isHTML:NO];
            composeVC.mailComposeDelegate = self;
            
            UIImage *image = [UIImage imageNamed:@"0.jpg"];
            [composeVC addAttachmentData:UIImageJPEGRepresentation(image, 0.6) mimeType:@"" fileName:@"123.jpg"];
            
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
