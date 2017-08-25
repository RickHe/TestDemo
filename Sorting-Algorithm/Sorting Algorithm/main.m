//
//  main.m
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/27.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickInsertSort.h"
#include <stdio.h>
#import "BinaryInsertSort.h"
#import "ShellSort.h"

#include<stdio.h>
#include<math.h>
#import "BubbleSort.h"
#import "QuickSort.h"
#import "HeapSort.h"
#import "MergeSort.h"

void merge1(int a[], int start, int mid, int end) {
    int leftCount = mid - start + 1;
    int rightCount = end - mid;
    int left[leftCount];
    int right[rightCount];
    // 左边数组
    for (int i = 0; i < leftCount; i++) {
        left[i] = a[start + i];
    }
    // 右边数组
    for (int j = 0; j < rightCount; j++) {
        right[j] = a[mid + j + 1];
    }
    // 合并到a中
    int i = 0;
    int j = 0;
    int k = start;
    while ( (i < leftCount) && (j < rightCount) ) {
        if (left[i] < right[j]) {
            a[k++] = left[i++];
        } else {
            a[k++] = right[j++];
        }
    }
    while (i < leftCount) {
        a[k++] = left[i++];
    }
    while (j < rightCount) {
        a[k++] = right[j++];
    }
}

// 合并
void merge(int a[], int start, int mid, int end)
{
    int n1 = mid - start + 1;
    int n2 = end - mid;
    int left[n1], right[n2];
    int i, j, k;
    
    for (i = 0; i < n1; i++) /* left holds a[start..mid] */
        left[i] = a[start+i];
    for (j = 0; j < n2; j++) /* right holds a[mid+1..end] */
        right[j] = a[mid+1+j];
    i = j = 0;
    k = start;
    while (i < n1 && j < n2)
        if (left[i] < right[j])
            a[k++] = left[i++];
        else
            a[k++] = right[j++];
    
    while (i < n1) /* left[] is not exhausted */
        a[k++] = left[i++];
    while (j < n2) /* right[] is not exhausted */
        a[k++] = right[j++];
}

// merge_sort()：先排序，再合并
void merge_sort(int a[], int start, int end)
{
    int mid;
    if (start < end)
    {
        mid = (start + end) / 2;
        // 分解 + 解决：Divide + Conquer
        merge_sort(a, start, mid); // 递归划分原数组左半边array[start...mid]
        merge_sort(a, mid+1, end); // 递归划分array[mid+1...end]
        // 合并：Combine
        merge(a, start, mid, end); // 合并
        printf("merge (%d-%d, %d-%d) to %d %d %d %d %d %d %d %d\n",
               start, mid, mid+1, end,
               a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
    }
}

void mergeSort(int *a, int start, int end) {
    int mid;
    if (start < end) {
        mid = (start + end) / 2;
        // 左边归并
        mergeSort(a, start, mid);
        // 右边归并
        mergeSort(a, mid + 1, end);
        // 合并左右两边
        merge1(a, start, mid, end);
    }
}

//void heapAdjust()

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *arr = [@[@(0), @(1), @(21), @(12), @(15), @(11), @(10), @(8), @(-1), @(0)] mutableCopy];
        int *a = (void *)malloc(arr.count * sizeof(int));
        for (int i = 0; i < arr.count; i++) {
            a[i] = [arr[i] intValue];
        }
        //mergeSort(a, 0, (int)arr.count - 1);
        MergeSort *sort = [MergeSort new];
        [sort objectiveCSort:arr];
       // [sort cSort:arr];
        //        heapSort(a, (int)arr.count);
        //        sort(a, 0, (int)arr.count - 1);
//                for (int i = 0; i < arr.count; i++) {
//                    printf("%d ", a[i]);
//                }
//                printf("\n");
        
        //QuickSort *sort = [QuickSort new];
        //[sort objectiveCSort:arr];
        //                [sort cSort:arr];
        
        return 0;
    }
}