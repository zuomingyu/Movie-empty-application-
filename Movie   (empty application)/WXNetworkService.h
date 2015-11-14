//
//  WXNetworkService.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXNetworkService : NSObject


// 测试数据
+ (id)testData;

// 北美票房数据
+ (id)northUSAData;
+ (id)northUSBData;

// 获取新闻数据
+ (id)newsData;


// 获取top电影数据
+ (id)topMovieData;

// 获取到影院数据
+ (id)cinemaData;

// 获取新闻页数据
+ (id)newsImageData;

// 获取到电影详情数据
+ (id)movieInfoData;

// 获取到电影评论数据
+ (id)movieCommentData;
@end
