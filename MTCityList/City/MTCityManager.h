//
//  MTCityManager.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTCityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTCityManager : NSObject

/// 写入本地城市列表
+ (void)writeProvinceCityToFile;

/// 获取所有城市的首字母
+ (NSMutableArray<NSString *> *)getCityFirstLetter;

/// 根据首字母获取一批城市
/// @param firstLetter 首字母
+ (NSMutableArray<NSArray <MTCityModel *> *> *)getCityWithFirstLetter:(NSString *)firstLetter;

/// 获取所有城市的列表MTCityModel
+ (NSMutableArray<MTCityModel *> *)getProvinceCityDate;

/// 根据code码获取 城市MTCityModel
/// @param code 城市code码
+ (MTCityModel *)getCityModelWithCityCode:(NSString *)code;

/// 根据name获取 城市MTCityModel
/// @param name 城市名字
+ (MTCityModel *)getCityModelWithCityName:(NSString *)name;

/// 模糊搜索
/// @param text 搜索的文字
/// @param searchSuccess 返回的数组
+ (void)searchWithText:(NSString *)text searchSuccess:(void (^)(NSMutableArray<MTCityModel *> *models))searchSuccess;


@end

NS_ASSUME_NONNULL_END
