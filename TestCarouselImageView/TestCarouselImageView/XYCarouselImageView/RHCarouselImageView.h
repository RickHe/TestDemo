//
//  XYCarouselImageView.h
//  Carousel Image Effect
//
//  Created by hmy2015 on 16/3/8.
//  Copyright © 2016年 何米颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHCarouselImageView : UIView

/**
 *  全能初始化
 *
 *  @param frame                    frame
 *  @param dataSource               图片名字
 *  @param mainImageWidthRatio      中间图片所占比例
 *  @param minimumInteritemSpacing  图片间隔
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource
          mainImageWidthRatio:(CGFloat)mainImageWidthRatio
      minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing;
/**
 *  初始化默认图片间隔为0
 *
 *  @param frame                    frame
 *  @param dataSource               图片名字
 *  @param mainImageWidthRatio      中间图片所占比例
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource
          mainImageWidthRatio:(CGFloat)mainImageWidthRatio;
/**
 *  初始化默认图片间隔为0,中间图片占比0.6
 *
 *  @param frame                    frame
 *  @param dataSource               图片名字
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource;

@property (nonatomic, readonly, strong) NSMutableArray *dataSource; // 数据
@property (nonatomic, readonly, assign) CGFloat mainImageWidthRatio;    // 中间图片所占比例
@property (nonatomic, readonly, assign) CGFloat minimumInteritemSpacing; // 图片间隔

@property (nonatomic, assign) CGFloat topInset;
@property (nonatomic, assign) CGFloat bottomInset;

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *currentPageDotColor;
@property (nonatomic, strong) UIColor *pageDotColor;

@property (nonatomic, assign) BOOL showPageControl;

- (void)removeTimer;

@end
