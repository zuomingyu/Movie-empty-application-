//
//  NSObject+MJKeyValue.h
//  MJExtension
//
//  Created by mj on 13-8-24.
//  Copyright (c) 2013年. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  KeyValue协议
 */
@protocol MJKeyValue <NSObject>
@optional
/**
 *  需要替换的key
 */
- (NSDictionary *)replaceKeys;
/**
 *  数组中需要转换的模型类
 */
- (NSDictionary *)arrayModelClasses;
@end

@interface NSObject (MJKeyValue) <MJKeyValue>
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典
 *  @return 新建的对象
 */
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues;
/**
 *  通过plist来创建一个模型
 *  @param filename 文件名
 *  @return 新建的对象
 */
+ (instancetype)objectWithFilename:(NSString *)filename;

/**
 *  通过字典数组来创建一个模型数组
 *  @param dictArray 字典数组
 *  @return 模型数组
 */
+ (NSArray *)modelArrayWithDictArray:(NSArray *)dictArray;

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名
 *  @return 模型数组
 */
+ (NSArray *)modelArrayWithFilename:(NSString *)filename;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典
 */
- (void)setKeyValues:(NSDictionary *)keyValues;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSDictionary *)keyValues;
@end
