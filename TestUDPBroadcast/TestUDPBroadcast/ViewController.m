//
//  ViewController.m
//  TestUDPBroadcast
//
//  Created by DaFenQi on 2017/5/19.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "ViewController.h"
#import "DFCUDPBroadcast.h"

@interface ViewController () <DFCUDPBroadcastDelegate>

@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [DFCUDPBroadcast sharedBroadcast].delegate = self;
}

- (IBAction)sendAction:(id)sender {
    [[DFCUDPBroadcast sharedBroadcast] sendMessage:_sendTextView.text];
}

- (void)udpSocketDidReceiveMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.receiveTextView.text = message;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
