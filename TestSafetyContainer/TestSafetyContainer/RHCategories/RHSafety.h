//
//  RHSafety.h
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/13.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * NSArray
 */
@interface NSArray (Safety)

- (id)SafetyObjectAtIndex:(NSUInteger)index;

@end


/*
 * NSMutableArray
 */
@interface NSMutableArray (Safety)

- (BOOL)SafetyAddObject:(id)anObject;
- (BOOL)SafetyInsertObject:(id)anObject atIndex:(NSUInteger)index;
- (BOOL)SafetyRemoveObject:(id)anObject;
- (BOOL)SafetyRemoveObjectAtIndex:(NSUInteger)index;
- (BOOL)SafetyReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

/*
 * NSMutableDictionary
 */
@interface NSMutableDictionary (Safety)

- (void)SafetySetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
