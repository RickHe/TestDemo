//
//  BinaryInsertSort.h
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

/**
 *  折半插入排序
 * 是对插入排序算法的一种改进,所谓的插入排序就是不断的依次将元素插入前面已经排好序的序列中
 * 改进具体步骤:由于前面的序列已经排好序,所以不需要按顺序查找!采用折半插入排序加快寻找插入点的速度
 */

/**
 *  折半插入排序寻找插入点算法流程
 *  1: 在寻找插入点的过程中:将首位已排序序列元素首位设置为a[row],末位设置为a[high]
 *  2: 折半查找设置 mid = (row + high) / 2, 设置一个元素a[0]保存带插入元素!
 *  3: 若a[0] > a[mid], 则a[0]应该插入a[mid]之后,所以low = mid + 1,继续第2步
 *  4: 最后得到row或者high + 1为插入位置,先从row到有序序列尾+1向后移动,插入元素到row!
 */

/**
 *  折半插入排序是一种稳定的排序算法
 *  由于减少了寻找插入位置的比较次数,增快了速度.但是循环次数相同所以时间复杂度依然为O(n^2)
 */

#import "BaseSort.h"

@interface BinaryInsertSort : BaseSort

- (void)objectiveCSort:(NSMutableArray *)arr;
- (void)cSort:(NSMutableArray *)arr;

@end
