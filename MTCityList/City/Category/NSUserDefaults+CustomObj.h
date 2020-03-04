//
//  NSUserDefaults+CustomObj.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (CustomObj)

/// 存储model 的本地方法
/// @param obj model 对象
/// @param key key
+ (void)setCustomObj:(id)obj forKey:(NSString *)key;

/// 获取本地存储的value
/// @param key key
+ (id)customObjForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
