//
//  ViewController.m
//  TestPPTToImage
//
//  Created by DaFenQI on 2017/8/21.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "ViewController.h"
#import "DFCPPTToImage.h"

@interface ViewController () <DFCPPTToImageDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *_imagePaths;
    DFCPPTToImage *_pptToImage;
    UICollectionView *_listView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (IBAction)convert:(id)sender {
    [self testPPTToImage];
}

- (void)setup {
    // success
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(160, 90);
    _listView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                    100,
                                                                                    self.view.bounds.size.width,
                                                                                    self.view.bounds.size.height - 100)
                                                    collectionViewLayout:layout];
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.dataSource = self;
    _listView.delegate = self;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)testPPTToImage {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"iOS" ofType:@"pptx"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    _pptToImage = [DFCPPTToImage createPdfWithURL:fileUrl delegate:self];
}

- (void)pptToImageDidSucceed:(DFCPPTToImage*)pptToImage imagePaths:(NSArray *)imagePaths {
    _imagePaths = imagePaths;
    [_listView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _imagePaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imgView.image = [[UIImage alloc] initWithContentsOfFile:_imagePaths[indexPath.row]];
    [cell.contentView addSubview:imgView];
    return cell;
}


- (void)pptToImageDidFail:(DFCPPTToImage*)pptToImage {
    NSLog(@"转换失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
