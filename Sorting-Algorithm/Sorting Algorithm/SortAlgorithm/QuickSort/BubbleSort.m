//
//  BubbleSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    for (int i = 0; i < arr.count - 1; i++) {
        for (int j = i + 1; j < arr.count; j++) {
            if ([arr[i] intValue] > [arr[j] intValue]) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
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
    cBubbleSort(a);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  快速排序
 */
static void cBubbleSort(int *a) {
    for (int i = 0; i < arrLength - 1; i++) {
        for (int j = i + 1; j < arrLength; j++) {
            if (a[i] > a[j]) {
                int temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
    }
}

/**
 *  快速排序改进版
 */
static void bubbleSort(int * a) {
    if (arrLength <= 1) {
        return;
    }
    for (int i = 0; i < arrLength - 1; i++) {
        for (int j = i + 1; j < arrLength; j++) {
            if (a[i] > a[j]) {
                int temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
    }
}

@end
