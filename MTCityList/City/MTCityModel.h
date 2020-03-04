//
//  MTCityModel.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTCityModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

NS_ASSUME_NONNULL_END
