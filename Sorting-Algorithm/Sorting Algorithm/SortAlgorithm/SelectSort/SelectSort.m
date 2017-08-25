//
//  SelectSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/30.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "SelectSort.h"

@implementation SelectSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    for (int i = 0; i < arrLength; i++) {
        int key = i;
        int j;
        for (j = i + 1; i < arrLength; j++) {
            if ([arr[key] intValue] > [arr[j] intValue]) {
                key = j;
            }
        }
        if (key != i) {
            NSNumber *temp = arr[i];
            arr[i] = arr[key];
            arr[key] = temp;
        }
    }
    for (NSNumber *num in arr) {
        NSLog(@"%@", num);
    }
}

- (void)cSort:(NSMutableArray *)arr {
    int *a = (void *)(malloc(sizeof(int) * arr.count));
    for (int i = 0; i < arr.count; i++) {
        a[i] = [arr[i] intValue];
    }
    arrLength = (int)arr.count;
    cSelectSort(a);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  选择排序排序
 */
static void cSelectSort(int *a) {
    if (arrLength <= 1) {
        return;
    }
    for (int i = 0; i < arrLength; i++) {
        int k = i;
        int j;
        for (j = i + 1; j < arrLength; j++) {
            if (a[j] < a[k]) {
                k = j;
            }
        }
        if (k != i) {
            int temp = a[k];
            a[k] = a[i];
            a[i] = temp;
        }
    }
}

@end
