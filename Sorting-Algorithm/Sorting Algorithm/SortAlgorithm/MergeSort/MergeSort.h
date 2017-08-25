//
//  MergeSort.h
//  Sorting Algorithm
//
//  Created by DaFenQi on 16/10/11.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#import "BaseSort.h"

/**
 *  归并排序
 */
/*
 (20)(40) (30)(60) (90)(100) (70)(80) (10   50)
 (20  40) (30  60) (90  100) (70  80) (10   50)
 (20  30   40  60) (70  80    90 100) (10   50)
 (20  30   40  60   70  80    90 100) (10   50)
 (10  20   30  40   50  60    70 80    90   100)
 */

@interface MergeSort : BaseSort

- (void)objectiveCSort:(NSMutableArray *)arr;
- (void)cSort:(NSMutableArray *)arr;

@end
