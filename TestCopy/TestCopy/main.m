//
//  main.m
//  Testttt
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "UserModel+Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        UserModel *model1 = [UserModel userWithName:@"s" Age:18 Sex:UserSexMan];
        UserModel *model2 = [UserModel userWithName:@"s" Age:18 Sex:UserSexMan];
        NSArray *arr1 = @[
                          model1,
                          model2
                          ];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arr1 copyItems:YES];
        UserModel *model = arr[0];
        model.nick = @"sda";
        model.test = @"ssssssa";
        NSLog(@"test = %@", model.test);
        NSLog(@"arr = %p,arr1 = %p", arr, arr1);
    }
    return 0;
}
