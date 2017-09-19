# RHCarouselImageView
### 基本使用
```
- (void)viewDidLoad {
    [super viewDidLoad];
    _carousel = [[RHCarouselImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) dataSource:@[@"1.jpg", @"2.jpg", @"3.jpg"] mainImageWidthRatio:0.6 minimumInteritemSpacing:10];
    _carousel.backgroundColor = [UIColor blackColor];
    _carousel.topInset = 5;
    _carousel.bottomInset = 5;
    _carousel.titles = [NSMutableArray arrayWithArray:@[@"第一页", @"第二页", @"第三页"]];
    [self.view addSubview:_carousel];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    // 移除定时器否则会照成循环引用
     [_carousel removeTimer];
}
```
### 额外属性
```
@property (nonatomic, assign) CGFloat topInset;       // 默认为0
@property (nonatomic, assign) CGFloat bottomInset;    // 默认为0

@property (nonatomic, strong) NSMutableArray *titles; // 若要显示文字，则设置该属性
@property (nonatomic, strong) UIFont *titleFont;      // 文字字体
@property (nonatomic, strong) UIColor *titleColor;    // 文字颜色

@property (nonatomic, assign) BOOL showPageControl;         // 默认显示 PageControl 圆点
@property (nonatomic, strong) UIColor *currentPageDotColor; // 当前页圆点颜色
@property (nonatomic, strong) UIColor *pageDotColor;        // 其他圆点颜色
```
[App Store iPad 端首页无限循环轮播效果实现思路](http://www.jianshu.com/p/66f82c8f9a4b)
