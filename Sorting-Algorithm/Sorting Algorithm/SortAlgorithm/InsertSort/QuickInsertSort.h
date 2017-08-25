//
//  QuickInsertSort.h
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/9/27.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "BaseSort.h"

/**
 *  快速插入排序
 * 每次从无序表中取一个元素出来将它插入有序表中使得有序表任然有序
 * 比较前两个数得到前两个有序数
 * 往后遍历每次将一个元素插入前面的有序表中
 * 快速排序有两层循环
 * 外循环标识需要插入有序序列的数
 * 内循环找出插入位置,并插入
 */

/**
 * 算法流程 由小到大排序
 *  r[j] 与 r[0, 1, ... j - 1],由右至左比较
 * 若r[j] > r[j - 1], 下一个元素
 * 若r[j] < r[j - 1], r[j] = r[j - 1], r[j]的值由temp变量保存,j--;以此类推
 * 结束上一步后得到的位置为需要插入的位置,将temp 赋值给该位置
 */

@interface QuickInsertSort : BaseSort

- (void)objectiveCSort:(NSMutableArray *)arr;
- (void)cSort:(NSMutableArray *)arr;

@end
