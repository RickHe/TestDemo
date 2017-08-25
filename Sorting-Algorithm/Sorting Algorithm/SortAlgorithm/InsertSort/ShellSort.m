//
//  ShellSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "ShellSort.h"

@implementation ShellSort

static int arrLength = 0;

- (void)objectiveCSort:(NSMutableArray *)arr {
    int time = log2(arr.count + 1);
    // 增量次数
    for (int i = 0; i < time; i++) {
        // 求增量
        int increment = (int)(pow(2, time - i) - 1);
        // 根据增量一次排序
        for (int j = increment; j < arr.count; j++) {
            int k, temp;
            temp = [arr[j] intValue];
            for (k = j - increment; (k >= 0) && (temp < [arr[k] intValue]); k -= increment) {
                arr[k + increment] = arr[k];
            }
            arr[k + increment] = @(temp);
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
    cShellSort(a);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}


/**
 *  希尔排序改进版
 */
static void shellSort(int *a) {
    if (arrLength <= 1) {
        return;
    }
    int times = (int)log2(arrLength + 1);
    for (int i = 0; i < times; i++) {
        int increment = (int)(pow(2, times - i) - 1);
        // 从increment开始执行插入算法
        for (int j = increment; j < arrLength; j++) {
            int temp = a[j];
            int k;
            // 每隔increment个元素为一组
            for (k = j - increment; j > 0 && temp < a[k]; j-= increment) {
                a[k + increment] = a[k];
            }
            a[k + increment] = temp;
        }
    }
}


/***************** 希尔排序开始 *******************/
/**
 *  希尔排序一个增量的排序
 */
static void shellSortInsert(int * a, int increment) {
    int i, j, temp;
    for (i = increment; i < arrLength; i++) {
        temp = a[i];
        for (j = i - increment; (j >= 0) && (temp < a[j]); j -= increment) {
            a[j + increment] = a[j];
        }
        a[j + increment] = temp;
    }
}

/**
 *  希尔排序
 */
static void cShellSort(int *a) {
    // 使用time个增量去排序
    int time = log2(arrLength + 1);
    for (int i = 0; i < time; i++) {
        // 求增量
        // 增量 = 2 ^ time - 1  || 2 ^ time - 1 ... 2 ^ 1 - 1
        shellSortInsert(a, hibbardIncrement(time - i));
    }
}

/**
 * 增量
 */
static int hibbardIncrement(int i) {
    return (int)(pow(2, i) - 1);
}
/***************** 希尔排序结束 *******************/

@end
