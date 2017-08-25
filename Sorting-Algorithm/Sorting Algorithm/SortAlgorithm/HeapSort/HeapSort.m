//
//  HeapSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/10/11.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "HeapSort.h"

@implementation HeapSort

static int arrLength = 0;
#pragma mark Objective-C
- (void)objectiveCSort:(NSMutableArray *)arr {
    [self objectiveCHeapSort:arr];
    for (NSNumber *num in arr) {
        NSLog(@"%@", num);
    }
}

/**
 *  堆排序oc实现
 *
 *  @param array 待排序数组
 */
- (void)objectiveCHeapSort:(NSMutableArray *)array {
    int length = (int)array.count;
    // 首次生成大顶堆
    for (int i = length / 2 - 1; i >= 0; i--) {
        [self objectiveCHeapAdjust:array
                             nodeI:i
                         maxLength:length];
    }
    for (int i = length - 1; i >= 0; i--) {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [self objectiveCHeapAdjust:array
                             nodeI:0
                         maxLength:i];
    }
    
}

/**
 *  某一分支(i位置到叶子节点这一分支)的最大堆
 *
 *  @param a    排序数组
 *  @param i    i位置分支
 *  @param max  堆的最大长度
 */
- (void)objectiveCHeapAdjust:(NSMutableArray *)array
                       nodeI:(NSUInteger)i
                   maxLength:(NSUInteger)max {
    NSUInteger j = i * 2 + 1;
    for (; j < max; j = j * 2 + 1) {
        if ((j + 1 < max) &&
            ([array[j] integerValue] < [array[j + 1] integerValue])) {
            j++;
        }
        if ([array[j] integerValue] < [array[i] integerValue]) {
            break;
        } else {
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i = j;
        }
    }
    
}

#pragma mark - C
- (void)cSort:(NSMutableArray *)arr {
    int *a = (void *)(malloc(sizeof(int) * arr.count));
    if (a == NULL) {
        return;
    }
    for (int i = 0; i < arr.count; i++) {
        a[i] = [arr[i] intValue];
    }
    arrLength = (int)arr.count;
    cHeapSort(a);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  选择排序排序
 */
static void cHeapSort(int *a) {
    if (arrLength <= 1) {
        return;
    }
    // 首次生成最大堆
    for (int i = arrLength / 2 - 1; i >= 0; i--) {
        cHeapAdjust(a, i, arrLength);
    }
    for (int j = arrLength - 1; j > 0; j--) {
        swap(a, 0, j);
        cHeapAdjust(a, 0, j - 1);
    }
}

/**
 *  某一分支(i位置到叶子节点这一分支)的最大堆
 *
 *  @param a    排序数组
 *  @param i    i位置分支
 *  @param max  堆的最大长度
 */
static void cHeapAdjust(int *a, int i, int max) {
    if ( (max > arrLength || max < 0) ||
         (i > arrLength || i < 0) ) {
        return;
    }
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
    int j;
    // j, j + 1 为 i 的左右孩子
    j = i * 2 + 1;
    for (; j < max; j = j * 2 + 1) {
        int temp = a[i];
        // 取出左右孩子较大孩子
        if ( (j + 1 < max) && (a[j] < a[j + 1])) {
            j++;
        }
        if (temp > a[j]) {
            break;
        } else {
            swap(a, i, j);
            // i往孩子节点移动
            // 目的,调整i到叶子节点的一个分支
            i = j;
        }
    }
}

/**
 *  交换元素
 *
 *  @param a 数组
 *  @param i i位置
 *  @param j j位置
 */
static void swap(int *a, int i, int j) {
    int temp = a[j];
    a[j] = a[i];
    a[i] = temp;
}


#pragma mark c
void printArr(int *a, int length) {
    for (int i = 0; i < length; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  生成第i个元素到第length个元素的最大堆
 *
 *  @param array  数组
 *  @param length 数组长度
 */
void heapAdjust(int array[], int i, int length) {
    int temp = array[i];
    // j 和 j + 1 为 i 的左右孩子节点
    int j = 2 * i + 1;
    for (; j < length; j = j * 2 + 1) {
        // 比较i的左右孩子节点,取较大节点j
        if ( (j + 1 < length) && (array[j] < array[j + 1]) ) {
            j++;
        }
        // 如果已经是最大堆,退出本次循环
        if (temp > array[j]) {
            break;
        } else {
            // 交换i, j
            swap(array, i, j);
            // 由于交换后下面的树可能顺序不是最大堆
            // 所以使得i = j 继续比较下面的堆
            i = j;
        }
    }
}

/**
 *  堆排序
 *
 *  @param array  数组
 *  @param length 数组长度
 */
void heapSort(int array[], int length) {
    // 首次生成一个最大堆或者最小堆
    for (int i = length / 2 - 1; i >= 0 ; i--) {
        heapAdjust(array, i, length);
    }
    // 每次生成最大堆后将第最后一个元素与第一个元素交换,
    // 剩余0到length - 1的树 调整0位置分支上的数字,继续生成最大堆
    for (int i = length - 1; i >= 0; i--) {
        swap(array, i, 0);
        heapAdjust(array, 0, i);
    }
}


@end
