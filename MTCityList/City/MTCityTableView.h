//
//  MTCItyTableView.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTCityTableView : UITableView

+ (instancetype)tableViewPlainGroupedWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray<NSString *> *indexes;
@property (nonatomic, strong) NSArray *dataModel;
@end

NS_ASSUME_NONNULL_END
