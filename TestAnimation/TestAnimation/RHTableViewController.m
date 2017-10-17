//
//  RHTableViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/12.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHTableViewController.h"

static NSString* const kCellId = @"cellId";

@interface RHTableViewItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSString *className;

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className;

@end

@implementation RHTableViewItem

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className {
    self = [super init];
    if (self) {
        _title = title;
        _className = className;
    }
    return self;
}

@end

@interface RHTableViewController () {
    NSArray *_tableViewItems;
}

@end

@implementation RHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    _tableViewItems = @[
                         [[RHTableViewItem alloc] initWithTitle:@"转场动画" className:@"RHTransitionAnimationViewController"],
                         [[RHTableViewItem alloc] initWithTitle:@"弹簧动画" className:@"RHSpringAnimationViewController"],
                         [[RHTableViewItem alloc] initWithTitle:@"普通动画" className:@"RHNormalAnimationViewController"],
                         [[RHTableViewItem alloc] initWithTitle:@"core animation" className:@"RHCoreAnimationViewController"]
                         ];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RHTableViewItem *tableViewItem = _tableViewItems[indexPath.row];
    Class class = NSClassFromString(tableViewItem.className);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    RHTableViewItem *tableViewItem = _tableViewItems[indexPath.row];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, cell.bounds.size.width - 44, cell.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:label];
    label.text = tableViewItem.title;
    
    label.layer.cornerRadius = 0.0f;
    
    return cell;
}

@end
