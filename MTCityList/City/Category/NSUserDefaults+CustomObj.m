//
//  NSUserDefaults+CustomObj.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "NSUserDefaults+CustomObj.h"

@implementation NSUserDefaults (CustomObj)

+ (void)setCustomObj:(id)obj forKey:(NSString *)key {
    if ([obj respondsToSelector:@selector(encodeWithCoder:)] == NO) {
        NSLog(@"对象存入失败！对象必须实现NSCoding 协议的 encodeWithCoder:方法");
        return;
    }
    NSData *encodeObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:encodeObject forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)customObjForKey:(NSString *)key {
    NSData *encodeObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (encodeObject == nil) {
        return nil;
    }
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:encodeObject];
    return obj;
}

@end
