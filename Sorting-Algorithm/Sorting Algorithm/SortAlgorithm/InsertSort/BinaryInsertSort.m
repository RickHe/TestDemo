//
//  BinaryInsertSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "BinaryInsertSort.h"

@implementation BinaryInsertSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    for (int i = 2; i < arr.count; i++) {
        int low = 1;
        int high = i - 1;
        arr[0] = arr[i];
        while (low <= high) {
            int mid = (low + high) / 2;
            if ([arr[0] intValue] > [arr[mid] intValue]) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        for (int j = i - 1; j >= low; j--) {
            arr[j + 1] = arr[j];
        }
        arr[low] = arr[0];
    }
    for (int i = 1; i < arrLength; i++) {
        NSLog(@"%@", arr[i]);
    }
}

- (void)cSort:(NSMutableArray *)arr {
    int *a = (void *)(malloc(sizeof(int) * arr.count));
    for (int i = 0; i < arr.count; i++) {
        a[i] = [arr[i] intValue];
    }
    arrLength = (int)arr.count;
    cBinaryInsertSort(a);
    for (int i = 1; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  改进版折半插入排序
 */
static void binaryInsertSort(int *a) {
    if (arrLength <= 2) {
        return;
    }
    for (int i = 2; i < arrLength; i++) {
        int low = 0;
        int high = i - 1;
        // 用于记录需要插入的记录
        a[0] = a[i];
        while (low <= high) {
            int mid = (low + high) / 2;
            if (a[0] >= a[mid]) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        int j;
        for (j = i - 1; j >= low; j--) {
            a[j + 1] = a[j];
        }
        a[low] = a[0];
    }
}

/**
 *  从第一位开始
 *  折半插入排序
 */
static void cBinaryInsertSort(int *a) {
    for (int i = 2; i < arrLength; i++) {
        // a[0]用于保存需要插入的元素
        a[0] = a[i];
        int low = 1;
        int high = i - 1;
        // 确定插入的位置为low
        while (low <= high) {
            int mid = (low + high) / 2;
            if (a[0] > a[mid]) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        for (int j = i - 1; j >= low; j--) {
            a[j + 1] = a[j];
        }
        a[low] = a[0];
    }
}

@end
