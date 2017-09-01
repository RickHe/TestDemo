//
//  XYCarouselImageView.m
//  Carousel Image Effect
//
//  Created by hmy2015 on 16/3/8.
//  Copyright © 2016年 何米颖. All rights reserved.
//

#import "RHCarouselImageView.h"
#import "UIImageView+RHCurrentImageIndex.h"

static NSTimeInterval kAnimationDuration = 0.3;
static NSInteger kNumberOfImageViewsToCreate = 5; // 复用
static CGFloat kDefaultMainImageWidthRatio = 0.6;
static CGFloat kDefaultMinimumInteritemSpacing = 6;
static CGFloat kDefaultAnimationDuration = 10.0f;

@interface RHCarouselImageView () {
    CGFloat _width;         // view宽度
    CGFloat _imageWidth;    // 图片宽度
    CGFloat _imageHeight;   // 图片高度
    NSTimer *_timer;        // 定时器
    BOOL _isScrolling;      // 不重复滑动
}

@end

@implementation RHCarouselImageView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource
          mainImageWidthRatio:(CGFloat)mainImageWidthRatio
      minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    if ((self = [super initWithFrame:frame])) {
        _isScrolling = NO;
        _dataSource = [NSMutableArray arrayWithArray:dataSource];
        _mainImageWidthRatio = mainImageWidthRatio;
        _minimumInteritemSpacing = minimumInteritemSpacing;
        _width = frame.size.width;
        _imageWidth = _mainImageWidthRatio * _width;
        _imageHeight = self.frame.size.height;
        
        if (_dataSource.count < kNumberOfImageViewsToCreate) {
            [_dataSource addObjectsFromArray:dataSource];
        }
        
        [self p_createViews];
        [self p_addGestures];
        [self p_addTimer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   dataSource:(NSArray *)dataSource
          mainImageWidthRatio:(CGFloat)mainImageWidthRatio {
    return [self initWithFrame:frame
                    dataSource:dataSource
           mainImageWidthRatio:kDefaultMainImageWidthRatio
       minimumInteritemSpacing:kDefaultMinimumInteritemSpacing];
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    return [self initWithFrame:frame
                    dataSource:dataSource
           mainImageWidthRatio:kDefaultMainImageWidthRatio
       minimumInteritemSpacing:kDefaultMinimumInteritemSpacing];
}

- (instancetype)initWithFrame:(CGRect)frame {
    [NSException exceptionWithName:@"error"
                            reason:@"please use initWithFrame:dataSource:mainImageWidthRatio: or initWithFrame:dataSource:"
                          userInfo:nil];
    return nil;
}

#pragma mark - setter
- (void)setTopInset:(CGFloat)topInset {
    _topInset = topInset;
    
    for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
        CGRect frame = imageView.frame;
        frame.origin.y = _topInset;
        frame.size.height -= _topInset;
        imageView.frame = frame;
    }
}

- (void)setBottomInset:(CGFloat)bottomInset {
    _bottomInset = bottomInset;
    
    for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
        CGRect frame = imageView.frame;
        frame.size.height -= _bottomInset;
        imageView.frame = frame;
    }
}

#pragma mark - Custom
- (void)p_createViews {
    for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self p_getFrameByIndex:i]];
        imageView.tag = i + 1;
        imageView.rh_currentImageIndex = @(i);
        imageView.image = [UIImage imageNamed:_dataSource[i]];
        [self addSubview:imageView];
    }
}

- (CGRect)p_getFrameByIndex:(NSInteger)index {
    
//    CGRectMake((1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + 4 * (_imageWidth + _minimumInteritemSpacing), 0, _imageWidth, _imageHeight);
    
    CGFloat originX = (1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + index * (_imageWidth + _minimumInteritemSpacing);
    return CGRectMake(originX,
                      _topInset,
                      _imageWidth,
                      _imageHeight - _topInset - _bottomInset);
}

- (CGRect)p_getLeftGestureFrame:(UIImageView *)imageView {
    CGFloat originX = imageView.frame.origin.x;
    imageView.frame = CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing), 0, _imageWidth, _imageHeight);
    
    return CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing),
                      _topInset,
                      _imageWidth,
                      _imageHeight - _topInset - _bottomInset);
}

- (CGRect)p_getRightGestureFrame:(UIImageView *)imageView {
    CGFloat originX = imageView.frame.origin.x;
    imageView.frame = CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing), 0, _imageWidth, _imageHeight);

    return CGRectMake(originX + 1 * (_imageWidth + _minimumInteritemSpacing),
                      _topInset,
                      _imageWidth,
                      _imageHeight - _topInset - _bottomInset);
}

- (void)p_addGestures {
    // 添加左滑手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    
    // 添加右滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
}

- (void)p_addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultAnimationDuration
                                              target:self
                                            selector:@selector(nextPage)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)nextPage {
    [self leftSwipeAction];
}

- (BOOL)isLastImageView:(UIImageView *)imageView {
    CGFloat originX = imageView.frame.origin.x;
    return (fabs(originX - ((1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + 4 * (_imageWidth + _minimumInteritemSpacing))) < 1);
}

- (BOOL)isFirstImageView:(UIImageView *)imageView {
    CGFloat originX = imageView.frame.origin.x;
    return (fabs(originX - ((1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + 0 * (_imageWidth + _minimumInteritemSpacing))) < 1);
}


#pragma mark - Gesture
- (void)leftSwipeAction {
    if (_isScrolling) {
        return;
    }
    
    UIImageView *tempImage;
    for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
        if ([self isFirstImageView:imageView])  {
            NSInteger currentIndex = [imageView.rh_currentImageIndex integerValue];
            imageView.rh_currentImageIndex = @((currentIndex + _dataSource.count - 1) % _dataSource.count);
            imageView.image = [UIImage imageNamed:_dataSource[(currentIndex + _dataSource.count - 1) % _dataSource.count]];
            imageView.frame = [self p_getFrameByIndex:kNumberOfImageViewsToCreate - 1];
            tempImage = imageView;
        }
    }

    _isScrolling = YES;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
            if (![self isFirstImageView:imageView] && ![imageView isEqual:tempImage]) {
                imageView.frame = [self p_getLeftGestureFrame:imageView];
            }
        }
    } completion:^(BOOL finished) {
        _isScrolling = NO;
    }];
}

- (void)rightSwipeAction {
    if (_isScrolling) {
        return;
    }
    
    UIImageView *tempImage;
    for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
        if ([self isLastImageView:imageView])  {
            NSInteger currentIndex = [imageView.rh_currentImageIndex integerValue];
            imageView.rh_currentImageIndex = @((currentIndex + 1) % _dataSource.count);
            imageView.image = [UIImage imageNamed:_dataSource[(currentIndex + 1) % _dataSource.count]];
            imageView.frame = [self p_getFrameByIndex:0];
            tempImage = imageView;
        }
    }

    _isScrolling = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        for (int i = 0; i < kNumberOfImageViewsToCreate; i++) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:i + 1];
            if (![self isLastImageView:imageView] && ![imageView isEqual:tempImage]) {
                imageView.frame = [self p_getRightGestureFrame:imageView];
            }
        }
    } completion:^(BOOL finished) {
        _isScrolling = NO;
    }] ;
}

@end
