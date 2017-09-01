//
//  XYCarouselcarouseCell.m
//  Carousel Image Effect
//
//  Created by hmy2015 on 16/3/8.
//  Copyright © 2016年 何米颖. All rights reserved.
//

#import "RHCarouselImageView.h"
#import "RHCarouseCell.h"

static NSTimeInterval kAnimationDuration = 0.3;
static NSInteger kNumberOfcarouseCellsToCreate = 5; // 复用
static CGFloat kDefaultMainImageWidthRatio = 0.6;
static CGFloat kDefaultMinimumInteritemSpacing = 6;
static CGFloat kDefaultAnimationDuration = 10.0f;

#define kPageControlFrame  CGRectMake((self.frame.size.width - _pageCount * 5) / 2, self.frame.size.height - 20, _pageCount * 5, 16);
#define kDefaultCurrentPageDotColor [UIColor grayColor]
#define kDefaultPageDotColor [UIColor blackColor]


@interface RHCarouselImageView () {
    CGFloat _width;         // view宽度
    CGFloat _imageWidth;    // 图片宽度
    CGFloat _imageHeight;   // 图片高度
    NSTimer *_timer;        // 定时器
    BOOL _isScrolling;      // 不重复滑动
    UIPageControl *_pageControl;
    NSInteger _pageCount;
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
        _pageCount = _dataSource.count;
        _showPageControl = YES;
        
        if (_dataSource.count < 3) {
            [NSException exceptionWithName:@"error"
                                    reason:@"at least 3 pages"
                                  userInfo:nil];
        }
        
        if (_dataSource.count < kNumberOfcarouseCellsToCreate) {
            [_dataSource addObjectsFromArray:_dataSource];
        }
        
        [self p_createViews];
        [self p_addGestures];
        [self p_addTimer];
        
        [self rightSwipeAction];
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
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    _pageControl.hidden = _showPageControl;
}

- (void)setPageDotColor:(UIColor *)pageDotColor {
    _pageDotColor = pageDotColor;
    _pageControl.pageIndicatorTintColor = _pageDotColor;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor {
    _currentPageDotColor = currentPageDotColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageDotColor;
}

- (void)setTopInset:(CGFloat)topInset {
    _topInset = topInset;
    
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        CGRect frame = carouseCell.frame;
        frame.origin.y = _topInset;
        frame.size.height -= _topInset;
        carouseCell.frame = frame;
    }
}

- (void)setBottomInset:(CGFloat)bottomInset {
    _bottomInset = bottomInset;
    
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        CGRect frame = carouseCell.frame;
        frame.size.height -= _bottomInset;
        carouseCell.frame = frame;
    }
}

- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    
    if (_titles.count < kNumberOfcarouseCellsToCreate) {
        [_titles addObjectsFromArray:_titles];
    }
    
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        carouseCell.title = _titles[i];
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        carouseCell.titleFont = _titleFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        carouseCell.titleColor = _titleColor;
    }
}

#pragma mark - Custom
- (void)p_createViews {
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = [[RHCarouseCell alloc] initWithFrame:[self p_getFrameByIndex:i]];
        carouseCell.tag = i + 1;
        carouseCell.currentImageIndex = i;
        carouseCell.image = [UIImage imageNamed:_dataSource[i]];
        [self addSubview:carouseCell];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = kPageControlFrame;
    _pageControl.numberOfPages = _pageCount;
    _pageControl.currentPageIndicatorTintColor = kDefaultCurrentPageDotColor;
    _pageControl.pageIndicatorTintColor = kDefaultPageDotColor;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPage = 2;
    [self addSubview:_pageControl];
}

- (CGRect)p_getFrameByIndex:(NSInteger)index {
    CGFloat originX = (1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + index * (_imageWidth + _minimumInteritemSpacing);
    return CGRectMake(originX,
                      _topInset,
                      _imageWidth,
                      _imageHeight - _topInset - _bottomInset);
}

- (CGRect)p_getLeftGestureFrame:(RHCarouseCell *)carouseCell {
    CGFloat originX = carouseCell.frame.origin.x;
    carouseCell.frame = CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing), 0, _imageWidth, _imageHeight);
    
    return CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing),
                      _topInset,
                      _imageWidth,
                      _imageHeight - _topInset - _bottomInset);
}

- (CGRect)p_getRightGestureFrame:(RHCarouseCell *)carouseCell {
    CGFloat originX = carouseCell.frame.origin.x;
    carouseCell.frame = CGRectMake(originX - 1 * (_imageWidth + _minimumInteritemSpacing), 0, _imageWidth, _imageHeight);

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

- (BOOL)isLastCarouseCell:(RHCarouseCell *)carouseCell {
    CGFloat originX = carouseCell.frame.origin.x;
    return (fabs(originX - ((1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + 4 * (_imageWidth + _minimumInteritemSpacing))) < 1);
}

- (BOOL)isFirstcarouseCell:(RHCarouseCell *)carouseCell {
    CGFloat originX = carouseCell.frame.origin.x;
    return (fabs(originX - ((1 - _mainImageWidthRatio) / 2 * _width - 2 * _minimumInteritemSpacing - 2 * _imageWidth + 0 * (_imageWidth + _minimumInteritemSpacing))) < 1);
}

#pragma mark - Gesture
- (void)leftSwipeAction {
    if (_isScrolling) {
        return;
    }
    
    RHCarouseCell *tempImage;
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        if ([self isFirstcarouseCell:carouseCell])  {
            NSInteger currentIndex = carouseCell.currentImageIndex;
            carouseCell.currentImageIndex = (currentIndex + _dataSource.count - 1) % _dataSource.count;
            carouseCell.image = [UIImage imageNamed:_dataSource[carouseCell.currentImageIndex]];
            
            if (carouseCell.currentImageIndex < _titles.count) {
                carouseCell.title = _titles[carouseCell.currentImageIndex];
            }
            
            carouseCell.frame = [self p_getFrameByIndex:kNumberOfcarouseCellsToCreate - 1];
            tempImage = carouseCell;
        }
    }

    _isScrolling = YES;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
            RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
            if (![self isFirstcarouseCell:carouseCell] && ![carouseCell isEqual:tempImage]) {
                carouseCell.frame = [self p_getLeftGestureFrame:carouseCell];
            }
        }
    } completion:^(BOOL finished) {
        _isScrolling = NO;
    }];
    
    _pageControl.currentPage = (_pageControl.currentPage + 1) % _pageCount;
}

- (void)rightSwipeAction {
    if (_isScrolling) {
        return;
    }
    
    RHCarouseCell *tempImage;
    for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
        RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
        if ([self isLastCarouseCell:carouseCell])  {
            NSInteger currentIndex = carouseCell.currentImageIndex;
            carouseCell.currentImageIndex = (currentIndex + 1) % _dataSource.count;
            
            carouseCell.image = [UIImage imageNamed:_dataSource[carouseCell.currentImageIndex]];
            if (carouseCell.currentImageIndex < _titles.count) {
                carouseCell.title = _titles[carouseCell.currentImageIndex];
            }
            
            carouseCell.frame = [self p_getFrameByIndex:0];
            tempImage = carouseCell;
        }
    }

    _isScrolling = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        for (int i = 0; i < kNumberOfcarouseCellsToCreate; i++) {
            RHCarouseCell *carouseCell = (RHCarouseCell *)[self viewWithTag:i + 1];
            if (![self isLastCarouseCell:carouseCell] &&
                ![carouseCell isEqual:tempImage]) {
                carouseCell.frame = [self p_getRightGestureFrame:carouseCell];
            }
        }
    } completion:^(BOOL finished) {
        _isScrolling = NO;
    }] ;
    
    _pageControl.currentPage = (_pageControl.currentPage + _pageCount - 1) % _pageCount;
}

@end
