//
//  MTCityManager.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityManager.h"
#import "NSUserDefaults+CustomObj.h"
#import "NSString+TransformLetter.h"

static NSString * _Nullable const MTCtiyALLCitysForKey  = @"MTCtiyALLCitysForKey";

static NSString * _Nullable const MTCtiyFirstLetterForKey  = @"MTCtiyFirstLetterForKey";

@implementation MTCityManager

+ (void)writeProvinceCityToFile {
    if (![NSUserDefaults customObjForKey:MTCtiyFirstLetterForKey]) {
        
        NSString *file =  [[NSBundle mainBundle] pathForResource:@"Area" ofType:@"json"];
        NSData *jdata = [NSData dataWithContentsOfFile:file];
    
        NSError *err;
        NSMutableArray<NSDictionary *> *jsonArr = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:&err];
        
        
        NSMutableArray *citys = [NSMutableArray array];
        NSMutableArray *cityLetters = [NSMutableArray array];
        NSMutableArray *allCitys = [NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *sortArr = [self paixuWithArr:jsonArr];
            [sortArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MTCityModel *model = [MTCityModel yy_modelWithDictionary:obj];
                NSString *str = [model.name getLetter];
                
                if (![str isEqualToString:[cityLetters lastObject]] && idx > 0) {
                    [NSUserDefaults setCustomObj:[citys mutableCopy] forKey:[cityLetters lastObject]];
                    [cityLetters addObject:str];
                    [citys removeAllObjects];
                }else if (idx == 0){
                    [cityLetters addObject:str];
                }else if (idx == sortArr.count - 1) {
                    [NSUserDefaults setCustomObj:[citys mutableCopy] forKey:[cityLetters lastObject]];
                }
                
                [citys addObject:model];
                [allCitys addObject:model];
            }];
        
            [NSUserDefaults setCustomObj:cityLetters forKey:MTCtiyFirstLetterForKey];
            [NSUserDefaults setCustomObj:allCitys forKey:MTCtiyALLCitysForKey];
        });
    }
}

#pragma mark 根据拼音的字母排序  ps：排序适用于所有类型
+ (NSMutableArray *)paixuWithArr:(NSMutableArray<NSDictionary *> *)array {
    [array sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSString *string1 = [obj1[@"name"] getLetter];
        NSString *string2 = [obj2[@"name"] getLetter];
        return [string1 compare:string2];
    }];
    return array;
}

+ (NSMutableArray<NSString *> *)getCityFirstLetter {
    return [NSUserDefaults customObjForKey:MTCtiyFirstLetterForKey];
}

+ (NSMutableArray<NSArray <MTCityModel *> *> *)getCityWithFirstLetter:(NSString *)firstLetter {
    return [NSUserDefaults customObjForKey:firstLetter];
}

+ (NSMutableArray<MTCityModel *> *)getProvinceCityDate {
    return [NSUserDefaults customObjForKey:MTCtiyALLCitysForKey];
}

+ (MTCityModel *)getCityModelWithCityCode:(NSString *)code {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code in %@",code];
    MTCityModel *model = [[[self getProvinceCityDate] filteredArrayUsingPredicate:predicate] firstObject];
    return model;
}

+ (MTCityModel *)getCityModelWithCityName:(NSString *)name {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name in %@",name];
    return [[[self getProvinceCityDate] filteredArrayUsingPredicate:predicate] firstObject];
}

+ (void)searchWithText:(NSString *)text searchSuccess:(void (^)(NSMutableArray<MTCityModel *> *models))searchSuccess {
    NSString *searchText = text;
    NSMutableArray<MTCityModel *> *searchArr = [NSMutableArray array];
    
      //加个多线程，否则数量量大的时候，有明显的卡顿现象
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
          if (searchText!=nil && searchText.length>0) {
              //遍历需要搜索的所有内容，其中searchArr为存放总数据的数组
              [[self getProvinceCityDate] enumerateObjectsUsingBlock:^(MTCityModel  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  //----------->把所有的搜索结果转成成拼音
                  NSString *pinyin = [self transformToPinyin:obj];
                  
                  if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                      //把搜索结果存放self.resultArray数组
                      [searchArr addObject:obj];
                  }
              }];
          }
          //回到主线程
          dispatch_async(dispatch_get_main_queue(), ^{
              searchSuccess(searchArr);
          });
      });
}

+ (NSString *)transformToPinyin:(MTCityModel *)model {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:model.name];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
 
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
 
    int count = 0;
 
    for (int i = 0; i < pinyinArray.count; i++) {
        for(int i = 0; i < pinyinArray.count;i++) {
            if (i == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    
    //拼音首字母
    NSMutableString *initialStr = [NSMutableString new];
    [pinyinArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length > 0) {
            [initialStr appendString:[obj getLetter]];
        }
        NSLog(@"%@",obj);
    }];
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",model.name];
    return allString;
}

@end
