//
//  MTCityModel.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityModel.h"

@implementation MTCityModel

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self == [super init]) {
        _code = [coder decodeObjectForKey:@"code"];
        _name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_code forKey:@"code"];
    [coder encodeObject:_name forKey:@"name"];
}

@end
