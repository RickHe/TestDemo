//
//  QuickInsertSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/27.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "QuickInsertSort.h"

@implementation QuickInsertSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    for (int i = 1; i < arr.count; i++) {
        if ([arr[i] integerValue] < [arr[i - 1] integerValue]) {
            for (int j = i; j > 0; j--) {
                if ([arr[j] integerValue] < [arr[j - 1] integerValue]) {
                    [arr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                }
            }
        }
    }
    for (NSNumber *number in arr) {
        NSLog(@"%@", number);
    }
}

- (void)cSort:(NSMutableArray *)arr {
    int *a = (void *)(malloc(sizeof(int) * arr.count));
    for (int i = 0; i < arr.count; i++) {
        a[i] = [arr[i] intValue];
    }
    arrLength = (int)arr.count;
    cQuickInsertSort(a);
    for (int i = 0; i < arrLength; i++) {
        NSLog(@"%d", a[i]);
    }
}

static void quickInsertSort(int * a) {
    if (arrLength <= 1) {
        return;
    }
    for (int i = 1; i < arrLength; i++) {
        int temp = a[i];
        int j;
        for (j = i - 1; j >= 0 && temp < a[j]; j--) {
            a[j + 1] = a[j];
        }
        a[j + 1] = temp;
    }
}

static void cQuickInsertSort(int *a) {
    int j;
    for (int i = 1; i < arrLength; i++) {
        if (a[i] < a[i - 1]) {
            int temp = a[i];
            for (j = i - 1; j >= 0 && a[j] > temp; j--) {
                a[j + 1] = a[j];
            }
            a[j + 1] = temp;
        }
    }
}

@end
