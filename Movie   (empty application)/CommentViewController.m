//
//  CommentViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "CommentViewController.h"
#import "WXNetworkService.h"
#import "MovieInfoModel.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "MainViewController.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"



@interface CommentViewController ()

- (void)loadHeaderView;

- (void)loadCommentTableView;

- (void)requsetCommentData;

- (void)requsetMovieInfoData;

- (void)refreshHeader;

- (void)refreshTable;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
    self.title = @"电影详情";
    [self requsetMovieInfoData];
    
    [self requsetCommentData];
}

#pragma mark - ViewCotroller Life
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    [self loadCommentTableView];
    
    [self loadHeaderView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 20, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"gray.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(share)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbtn=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightbtn;
    
}
-(void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56342cf267e58ef5d7005723"
                                      shareText:@"摩尔庄园2海妖宝藏"
                                     shareImage:[UIImage imageNamed:@"7.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToFacebook,UMShareToQzone,UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (self.navigationController.viewControllers.count == 1) {
//        
//        MainViewController *mainVC = (MainViewController *)self.tabBarController;
//        [mainVC showOrHiddenTabBarView:NO];
//    }
//}


#pragma mark - Private Method
- (void)loadHeaderView
{
    // 头部视图
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = [UIColor clearColor];
    
    // 电影的海报视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 150)];
    imgView.tag = 101;
    imgView.backgroundColor = [UIColor redColor];
    [_headerView addSubview:imgView];
    
    // 电影的标题视图
    UILabel *movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, imgView.top, 180, 30)];
    movieTitle.tag = 102;
    movieTitle.backgroundColor = [UIColor clearColor];
    movieTitle.textColor = [UIColor whiteColor];
    movieTitle.font = [UIFont boldSystemFontOfSize:16];
    [_headerView addSubview:movieTitle];
    
    // 电影的导演
    UILabel *director = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, movieTitle.bottom, 180, 30)];
    director.tag = 103;
    director.backgroundColor = [UIColor clearColor];
    director.textColor = [UIColor whiteColor];
    director.font = [UIFont boldSystemFontOfSize:16];
    [_headerView addSubview:director];
    
    // 电影的演员
    UILabel *actors = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, director.bottom, 180, 30)];
    actors.tag = 104;
    actors.backgroundColor = [UIColor clearColor];
    actors.textColor = [UIColor whiteColor];
    actors.font = [UIFont boldSystemFontOfSize:16];
    [_headerView addSubview:actors];
    
    // 电影的类型
    UILabel *movieType = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, actors.bottom, 180, 30)];
    movieType.tag = 105;
    movieType.backgroundColor = [UIColor clearColor];
    movieType.textColor = [UIColor whiteColor];
    movieType.font = [UIFont boldSystemFontOfSize:16];
    [_headerView addSubview:movieType];
    
    // 电影的上映日期
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, movieType.bottom, 180, 30)];
    date.tag = 106;
    date.backgroundColor = [UIColor clearColor];
    date.textColor = [UIColor whiteColor];
    date.font = [UIFont boldSystemFontOfSize:16];
    [_headerView addSubview:date];
    
    // 想看的按钮
    UIButton *interestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [interestButton setTitle:@"想看" forState:UIControlStateNormal];
    [interestButton setBackgroundImage:[UIImage imageNamed:@"xk"] forState:UIControlStateNormal];
    [interestButton setBackgroundImage:[UIImage imageNamed:@"xk_on"] forState:UIControlStateHighlighted];
    [interestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    interestButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    interestButton.frame = CGRectMake(20, imgView.bottom + 10, 140, 40);
    [interestButton addTarget:self action:@selector(openweb) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:interestButton];
    
    // 评分的按钮
    UIButton *ratingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ratingButton setTitle:@"评分" forState:UIControlStateNormal];
    [ratingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ratingButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [ratingButton setBackgroundImage:[UIImage imageNamed:@"ypf"] forState:UIControlStateNormal];
    [ratingButton setBackgroundImage:[UIImage imageNamed:@"ypf_on"] forState:UIControlStateHighlighted];
    ratingButton.frame = CGRectMake(interestButton.right, imgView.bottom + 10, 140, 40);
    [_headerView addSubview:ratingButton];
    
    // 初始化表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, ratingButton.bottom, 300, 270) style:UITableViewStyleGrouped];
    tableView.scrollEnabled = NO;
    tableView.tag = 107;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [_headerView addSubview:tableView];
    
    // 设置头部视图的高度
    _headerView.height = tableView.bottom+10;
    _commentTableView.tableHeaderView = _headerView;
}

-(void)openweb
{
    NSString *urlstring=@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621112404690593.mp4";
    
    MPMoviePlayerViewController *player=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlstring]];
    
    [self presentViewController:player animated:YES completion:nil];
}

- (void)loadCommentTableView
{
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kDeviceHeight-20-44) style:UITableViewStylePlain];
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _commentTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_commentTableView];
}

////////////////////////////////////////////////////////////////////////////////

- (void)requsetCommentData
{
    NSArray *data = [WXNetworkService movieCommentData];
    
    _commentsArray=[NSArray array];

    _commentsArray=[CommentModel modelArrayWithDictArray:data];
    
    [self refreshTable];
}

- (void)requsetMovieInfoData
{
    NSDictionary *dic = [WXNetworkService movieInfoData];
    
    _movieInfoModel=[[MovieInfoModel alloc]init];
    
    //第三方框架中的方法，字典变model
    [_movieInfoModel setKeyValues:dic];
    
    
    [self refreshHeader];
}

////////////////////////////////////////////////////////////////////////////////

- (void)refreshHeader
{
    // 电影的海报视图
    UIImageView *imgView = (UIImageView *)[_headerView viewWithTag:101];
    [imgView setImageWithURL:[NSURL URLWithString:_movieInfoModel.image]];
    
    // 电影的标题视图
    UILabel *movieTitle = (UILabel *)[_headerView viewWithTag:102];
    movieTitle.text = _movieInfoModel.titleCn;
    
    // 导演
    UILabel *director = (UILabel *)[_headerView viewWithTag:103];
    director.text = [_movieInfoModel.directors componentsJoinedByString:@", "];
    //NSLog(@"%@", [_movieInfoModel.directors componentsJoinedByString:@","]);
    
    // 演员
    UILabel *actors = (UILabel *)[_headerView viewWithTag:104];
    actors.text = [_movieInfoModel.actors componentsJoinedByString:@", "];
    
    // 类型
    UILabel *type = (UILabel *)[_headerView viewWithTag:105];
    type.text = [_movieInfoModel.types componentsJoinedByString:@", "];
    
    // 发布日期
    UILabel *release = (UILabel *)[_headerView viewWithTag:106];
    NSArray *releaseDate = [_movieInfoModel.release2 allValues];
    release.text = [releaseDate componentsJoinedByString:@", "];
    
    UITableView *tableView = (UITableView *)[_headerView viewWithTag:107];
    [tableView reloadData];
}

- (void)refreshTable
{
    [_commentTableView reloadData];
}


#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_commentTableView == tableView) {
        return 10;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_commentTableView == tableView) {
        
        static NSString *cellIdentifier = @"cell";
        
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.commentModel = _commentsArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            
            int x = 0;
            for (int index = 0; index < _movieInfoModel.images.count; index++) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+x, 5, 60, 60)];
                NSString *imgURL = _movieInfoModel.images[index];
                [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
                x += (imgView.width + 5);
                [cell.contentView addSubview:imgView];
            }
            
        }else if (indexPath.row == 1) {
            
            cell.textLabel.text = _movieInfoModel.content;
            
        }else if (indexPath.row == 2) {
            
            NSString *actors = [_movieInfoModel.actors componentsJoinedByString:@", "];
            cell.textLabel.text = [NSString stringWithFormat:@"职员表: %@", actors];
            
        }else {
            
            int x = 0;
            for (int index = 0; index < _movieInfoModel.videos.count; index++) {
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15+x, 5, 80, 60)];
                NSDictionary *dic = [_movieInfoModel.videos objectAtIndex:index];
                NSString *imgURL = [dic objectForKey:@"image"];
                [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
                x += (imgView.width + 5);
                [cell.contentView addSubview:imgView];
                
            }
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_commentTableView == tableView) {
        
        CommentModel *commentModel = _commentsArray[indexPath.row];
        CGSize size = [commentModel.content sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(220, 10000)];
        return size.height+20+20;
    }else {
        if (indexPath.row == 0 || indexPath.row == 3) {
            return 70;
        }else {
            return 50;
        }
    }
}



@end
