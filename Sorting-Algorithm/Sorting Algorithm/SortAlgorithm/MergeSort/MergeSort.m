//
//  MergeSort.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/10/11.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "MergeSort.h"

@implementation MergeSort

static int arrLength = 0;

#pragma mark - 递归实现
#pragma mark - Objective-C
- (void)objectiveCSort:(NSMutableArray *)arr {
    //[self objectiveCMergeSort:arr left:0 right:arr.count - 1];
    [self objectiveCNonRecursiveMergeSort:arr];
    for (NSNumber *num in arr) {
        NSLog(@"%@", num);
    }
}

/**
 *  堆排序oc实现
 *
 *  @param array 待排序数组
 */
- (void)objectiveCMergeSort:(NSMutableArray *)array
                       left:(NSUInteger)left
                      right:(NSUInteger)right {
    if (left < right) {
        NSUInteger mid = (left + right) / 2;
        [self objectiveCMergeSort:array left:left right:mid];
        [self objectiveCMergeSort:array left:mid + 1 right:right];
        [self objectiveCMerge:array left:left mid:mid right:right];
    }
}

/**
 *  某一分支(i位置到叶子节点这一分支)的最大堆
 *
 *  @param a    排序数组
 *  @param i    i位置分支
 *  @param max  堆的最大长度
 */
- (void)objectiveCMerge:(NSMutableArray *)array
                   left:(NSUInteger)left
                    mid:(NSUInteger)mid
                  right:(NSUInteger)right {
    NSUInteger leftCount = mid - left + 1;
    NSUInteger rightCount = right - mid;
    NSMutableArray *leftArray = [[NSMutableArray alloc] initWithCapacity:leftCount];
    NSMutableArray *rightArray = [[NSMutableArray alloc] initWithCapacity:rightCount];
    for (int i = 0; i < leftCount; i++) {
        [leftArray addObject:array[left + i]];
    }
    for (int j = 0; j < rightCount; j++) {
        [rightArray addObject:array[mid + j + 1]];
    }
    NSUInteger i = 0;
    NSUInteger j = 0;
    NSUInteger k = left;
    while (i < leftCount && j < rightCount) {
        if ([leftArray[i] integerValue] < [rightArray[j] integerValue]) {
            array[k++] = leftArray[i++];
        } else {
            array[k++] = rightArray[j++];
        }
    }
    while (i < leftCount) {
        array[k++] = leftArray[i++];
    }
    while (j < rightCount) {
        array[k++] = rightArray[j++];
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
    cNonRecursiveMergeSort(a);
    //    cMergeSort(a, 0, arrLength - 1);
    for (int i = 0; i < arrLength; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

/**
 *  合并a[left]->a[mid] 和 a[mid + 1]->a[right]两个序列
 *
 *  @param a     数组
 *  @param left
 *  @param mid
 *  @param right
 */
static void cMerge(int *a, int left, int mid, int right) {
    int leftCount = mid - left + 1;
    int rightCount = right - mid;
    int leftA[leftCount];
    int rightA[rightCount];
    // 左边数组
    for (int i = 0; i < leftCount; i++) {
        leftA[i] = a[left + i];
    }
    // 右边数组
    for (int j = 0; j < rightCount; j++) {
        rightA[j] = a[mid + j + 1];
    }
    int i = 0, j = 0, k = left;
    // 合并
    while ((i < leftCount) && (j < rightCount)) {
        if (leftA[i] < rightA[j]) {
            a[k++] = leftA[i++];
        } else {
            a[k++] = rightA[j++];
        }
    }
    // 左边有余
    while (i < leftCount) {
        a[k++] = leftA[i++];
    }
    // 右边有余
    while (j < rightCount) {
        a[k++] = rightA[j++];
    }
}

/**
 *  归并排序递归实现
 */
static void cMergeSort(int *a, int left, int right) {
    if (arrLength <= 1) {
        return;
    }
    if (left < right) {
        int mid = (left + right) / 2;
        // 左边排序
        cMergeSort(a, left, mid);
        // 右边排序
        cMergeSort(a, mid + 1, right);
        // 合并
        cMerge(a, left, mid, right);
    }
}

#pragma mark - 非递归实现
#pragma mark - C
static void cNonRecursiveMergeSort(int *a) {
    /*
     (20)(40) (30)(60) (90)(100) (70)(80) (10)
     (20  40) (30  60) (90  100) (70  80) (10)
     (20  40   30  60) (90  100) (70  80) (10)
     (20  40   30  60   90  100   70  80) (10)
     (20  40   30  60   90  100   70  80   10)
     */
    // i 为 括号里面的数字个数
    // j 为每一个括号的起始位置
    // k 用来算间隔 (2 ^ k - 1)
    // left = j;
    // mid = j + (int)(pow(2, k) - 1);
    // right = j + i * 2 - 1;
    int k = -1;
    // i 表示 i位一起合并
    for (int i = 1; i < arrLength; i = i * 2) {
        k++;
        // j 表示起始位置
        for (int j = 0; j < arrLength; j = j + 2 * i) {
            int left = j;
            int mid = j + (int)(pow(2, k) - 1);
            int right = j + i * 2 - 1;
            if (mid + 1 < arrLength) {
                if (right > arrLength - 1) {
                    cMerge(a, left, mid, arrLength - 1);
                } else {
                    cMerge(a, left, mid, right);
                }
            }
        }
    }
}

#pragma mark - Objective-C
- (void)objectiveCNonRecursiveMergeSort:(NSMutableArray *)array {
    int k = -1;
    for (int i = 1; i < array.count; i *= 2) {
        k++;
        for (int j = 0; j < array.count; j = j + 2 * i) {
            int left = j;
            int mid = j + (int)(pow(2, k) - 1);
            int right = j + 2 * i - 1;
            if (mid + 1 < array.count) {
                if (right > array.count - 1) {
                    [self objectiveCMerge:array left:left mid:mid right:array.count - 1];
                } else {
                    [self objectiveCMerge:array left:left mid:mid right:right];
                }
            }
        }
    }
}

@end
