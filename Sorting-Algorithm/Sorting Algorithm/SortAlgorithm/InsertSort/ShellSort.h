//
//  ShellSort.h
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/28.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

/**
 *  希尔排序
 * 按照一定的增量分组,对每组使用插入排序,随着增量的减小,一个组内的关键字越来越多,当为1的时候排序成功
 *  希尔排序是基于插入排序以下特点进行效率改进的
 * 1: 插入排序当顺序几乎已经排好的情况下,效率很高几乎线性
 * 2: 插入排序一般是效率低效的,因为插入排序每次只能将数据移动一位
 * 极限情况时间复杂度可为O(nlog(2n)), Hibbard时间复杂度O(n ^ 3/2)
 * 减少数据的移动,原因,当增量大的时候每一分组数字少!当增量变小的时候每一分组数字多的时候这时序列顺序变规则移动会减少
 * 这时候
 */

#import "BaseSort.h"

@interface ShellSort : BaseSort

- (void)objectiveCSort:(NSMutableArray *)arr;
- (void)cSort:(NSMutableArray *)arr;

@end
