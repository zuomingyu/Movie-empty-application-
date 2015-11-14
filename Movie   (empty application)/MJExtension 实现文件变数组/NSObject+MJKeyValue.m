//
//  NSObject+MJKeyValue.m
//  MJExtension
//
//  Created by mj on 13-8-24.
//  Copyright (c) 2013年. All rights reserved.
//

#import "NSObject+MJKeyValue.h"
#import "NSObject+MJMember.h"

@implementation NSObject (MJKeyValue)
#pragma mark - 公共方法
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典
 *  @return 新建的对象
 */
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues
{
    if (![keyValues isKindOfClass:[NSDictionary class]]) {
        [NSException raise:@"keyValues is not a NSDictionary" format:nil];
    }
    
    id model = [[self alloc] init];
    [model setKeyValues:keyValues];
    return model;
}

/**
 *  通过plist来创建一个模型
 *  @param filename 文件名
 *  @return 新建的对象
 */
+ (instancetype)objectWithFilename:(NSString *)filename
{
    NSDictionary *keyValues = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:nil]];
    return [self objectWithKeyValues:keyValues];
}

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典
 */
- (void)setKeyValues:(NSDictionary *)keyValues
{
    if (![keyValues isKindOfClass:[NSDictionary class]]) {
        [NSException raise:@"keyValues is not a NSDictionary" format:nil];
    }
    
    [self enumerateIvarsWithBlock:^(MJIvar *ivar, BOOL *stop) {
        if (ivar.isSrcClassFromFoundation) return;
        
        // 1.取出属性值
        NSString *key = [self keyWithPropertyName:ivar.propertyName];
        id value = keyValues[key];
        if (!value) return;
        
        // 2.获得成员变量类型
        if (ivar.type.typeClass && !ivar.type.fromFoundation) {
            value = [ivar.type.typeClass objectWithKeyValues:value];
        }
        
        // 3.处理数组里面有模型的情况
        value = [self modelArrayWithDictArray:value propertyName:ivar.propertyName];
        
        // 4.赋值
        ivar.value = value;
    }];
}

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSDictionary *)keyValues
{
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    
    [self enumerateIvarsWithBlock:^(MJIvar *ivar, BOOL *stop) {
        if (ivar.isSrcClassFromFoundation) return;
        
        // 1.取出属性值
        id value = ivar.value;
        if (!value) return;
        
        // 2.查看对象类型
        if (ivar.type.typeClass && !ivar.type.fromFoundation) {
            value = [value keyValues];
        }
        
        // 3.数组处理
        value = [self dictArrayWithModelArray:value propertyName:ivar.propertyName];
        
        // 4.赋值
        NSString *key = [self keyWithPropertyName:ivar.propertyName];
        keyValues[key] = value;
    }];
    
    return keyValues;
}

/**
 *  通过字典数组来创建一个模型数组
 *  @param dictArray 字典数组
 *  @return 模型数组
 */
+ (NSArray *)modelArrayWithDictArray:(NSArray *)dictArray
{
    // 1.判断真实性
    if (![dictArray isKindOfClass:[NSArray class]]) {
        [NSException raise:@"dictArray is not a NSArray" format:nil];
    }
    
    // 2.创建数组
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 3.遍历
    for (NSDictionary *dict in dictArray) {
        if (![dict isKindOfClass:[NSDictionary class]]) continue;
        
        id model = [self objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名
 *  @return 模型数组
 */
+ (NSArray *)modelArrayWithFilename:(NSString *)filename
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:nil]];
    return [self modelArrayWithDictArray:array];
}

#pragma mark - 私有方法
/**
 *  根据属性名获得对应的key
 *
 *  @param propertyName 属性名
 *
 *  @return 字典的key
 */
- (NSString *)keyWithPropertyName:(NSString *)propertyName
{
    NSString *key = nil;
    // 1.查看有没有需要替换的key
    if ([self respondsToSelector:@selector(replaceKeys)]) {
        key = self.replaceKeys[propertyName];
    }
    // 2.用属性名作为key
    if (!key) key = propertyName;
    
    return key;
}

/**
 *  根据字典数组产生模型数组
 *
 *  @param dictArray 字典数组
 *
 *  @return 模型数组
 */
- (NSArray *)modelArrayWithDictArray:(NSArray *)dictArray propertyName:(NSString *)propertyName
{
    // 1.过滤
    if (![dictArray isKindOfClass:[NSArray class]]) return dictArray;
    if (![self respondsToSelector:@selector(arrayModelClasses)]) return dictArray;
    
    // 2.创建数组
    NSMutableArray *modelArray = [NSMutableArray array];
    Class modelClass = self.arrayModelClasses[propertyName];
    // 如果还是没有对应的模型class
    if (modelClass == nil) return dictArray;
    
    for (NSDictionary *dict in dictArray) {
        id model = [modelClass objectWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

/**
 *  根据模型数组产生字典数组
 *
 *  @param modelArray 模型数组
 *
 *  @return 字典数组
 */
- (NSArray *)dictArrayWithModelArray:(NSArray *)modelArray propertyName:(NSString *)propertyName
{
    // 1.过滤
    if (![modelArray isKindOfClass:[NSArray class]]) return modelArray;
    if (![self respondsToSelector:@selector(arrayModelClasses)]) return modelArray;
    
    Class modelClass = self.arrayModelClasses[propertyName];
    // 如果还是没有对应的模型class
    if (modelClass == nil) return modelArray;
    
    if (![[modelArray lastObject] isKindOfClass:modelClass]) return modelArray;
    
    // 2.创建数组
    NSMutableArray *dictArray = [NSMutableArray array];
    for (id model in modelArray) {
        [dictArray addObject:[model keyValues]];
    }
    
    return dictArray;
}
@end
