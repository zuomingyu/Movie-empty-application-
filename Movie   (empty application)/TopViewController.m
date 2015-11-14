//
//  TopViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "TopViewController.h"
#import "WXNetworkService.h"
#import "MJExtension.h"
#import "TopModel.h"
#import "TopCell.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@interface TopViewController ()

- (void)requestData;

- (void)refreshUI;

@end

@implementation TopViewController

#pragma mark - ViewController Life
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    
    
    // 初始化表视图
    _topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _topTableView.dataSource = self;
    _topTableView.delegate = self;
    _topTableView.hidden = YES;
    _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _topTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_topTableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"top 250";
    [self requestData];
}
#pragma mark - Private Mehtod
- (void)requestData
{
    NSArray *data = [WXNetworkService topMovieData];

    NSArray *array=[NSArray array];
    
    array=[TopModel modelArrayWithDictArray:data];
    
    
    // 创建二维数组
    NSMutableArray *temp = nil;
    _rowsArray = [[NSMutableArray alloc] init];
    for (int index = 0; index < array.count; index++) {
        
        TopModel *topModel = array[index];
        
        if (index % 3 == 0) {
            temp = [[NSMutableArray alloc] initWithCapacity:3];
            [_rowsArray addObject:temp];
            
        }
        
        [temp addObject:topModel];

        
    }
    
    // 刷新UI
    [self refreshUI];
}

- (void)refreshUI
{
    [_topTableView reloadData];
    
    _topTableView.hidden = NO;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义静态标识符
    static NSString *cellIdentifier = @"cell";
    
    // 检查表视图中是否存在闲置的单元格
    TopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[TopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.imagesArray = _rowsArray[indexPath.row];
    cell.backgroundColor =  [UIColor  clearColor];
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _rowsArray.count-1) {
        return 170;
    }else {
        return 150;
    }
}
@end
