//
//  NSString+TransformLetter.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "NSString+TransformLetter.h"

@implementation NSString (TransformLetter)

- (NSString *)getLetter {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self polyphoneStringHandleWithPinyinString:pinyinString] uppercaseString];
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
    
}

/**
 多音字处理
 */
- (NSString *)polyphoneStringHandleWithPinyinString:(NSString *)pinyinString {
    if ([self hasPrefix:@"长"]) { return @"chang";}
    if ([self hasPrefix:@"沈"]) { return @"shen"; }
    if ([self hasPrefix:@"厦"]) { return @"xia";  }
    if ([self hasPrefix:@"地"]) { return @"di";   }
    if ([self hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}

@end
