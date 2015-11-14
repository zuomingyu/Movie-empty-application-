//
//  WXNetworkService.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "WXNetworkService.h"

@implementation WXNetworkService


+ (id)parserData:(NSString *)name
{
    // 获取到包文件的根目录 沙盒应用程序.app路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    // 根据传入的名字拼接
    NSString *path = [resourcePath stringByAppendingPathComponent:name];
    
    // 将路径下的数据读出来
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id result = nil;//返回的数据可能是数组也可能是一个字典
    
    result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    
    return result;
}// JSON数据解析

+ (id)testData
{
    return [self parserData:@"test.json"];
}



+ (id)northUSAData
{
    //return [[self parserData:@"NorthUSA.json"] objectForKey:@"title"];
    return [[self parserData:@"NorthUSA.json"] objectForKey:@"subjects"];
}
+ (id)northUSBData
{
    //return [[self parserData:@"NorthUSA.json"] objectForKey:@"title"];
    return [[self parserData:@"NorthUSB.json"] objectForKey:@"subjects"];
}
+ (id)newsData
{
    return [self parserData:@"news_list.json"];
}


+ (id)topMovieData
{
    return [[self parserData:@"movie_list.json"] objectForKey:@"entries"];
    
}


+ (id)cinemaData
{
    return [self parserData:@"readyMovie.json"];
}


+ (id)newsImageData
{
    return [self parserData:@"news_detail_images.json"];
}

+ (id)movieInfoData
{
    return [self parserData:@"movie_detail.json"];
}

+ (id)movieCommentData
{
    return [[self parserData:@"movie_comment.json"] objectForKey:@"list"];
}

@end
