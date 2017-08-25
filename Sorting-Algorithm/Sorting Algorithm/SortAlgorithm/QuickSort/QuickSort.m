//
//  QuickSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    [self quickSort:arr left:0 right:(int)arr.count - 1];
    for (NSNumber *num in arr) {
        NSLog(@"%@", num);
    }
}

- (void)quickSort:(NSMutableArray *)arr left:(int)left right:(int)right {
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    int key = [arr[left] intValue];
    while (i < j) {
        while (i < j && key <= [arr[j] intValue]) {
            j--;
        }
        arr[i] = arr[j];
        while (i < j && key >= [arr[i] intValue]) {
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = @(key);
    [self quickSort:arr left:i + 1 right:right];
    [self quickSort:arr left:left right:i - 1];
}

- (void)cSort:(NSMutableArray *)arr {
    int *a = (void *)(malloc(sizeof(int) * arr.count));
    for (int i = 0; i < arr.count; i++) {
        a[i] = [arr[i] intValue];
    }
    arrLength = (int)arr.count;
    cQuickSort(a, 0, arrLength - 1);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  改进版快速排序算法
 */
static void quickSort(int *a, int left, int right) {
    // 容错,边界处理
    if (arrLength == 1) {
        return;
    }
    if (left < 0 && left >= arrLength) {
        return;
    }
    if (left >= right) {
        return;
    }
    // 排序开始
    int i = left;
    int j = right;
    int key = a[left];
    while (i < j) {
        while (i < j && key <= a[j]) {
            j--;
        }
        a[i] = a[j];
        while (i < j && key >= a[i]) {
            i++;
        }
        a[j] = a[i];
    }
    a[i] = key;
    quickSort(a, i + 1, right);
    quickSort(a, left, i - 1);
}

/**
 *  快速排序
 */
static void cQuickSort(int *a, int left, int right) {
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    int key = a[left];
    while (i < j) {
        while (i < j && key <= a[j]) {
            j--;
        }
        a[i] = a[j];
        while (i < j && key >= a[i]) {
            i++;
        }
        a[j] = a[i];
    }
    a[i] = key;
    cQuickSort(a, i + 1, right);
    cQuickSort(a, left, i - 1);
}

@end
