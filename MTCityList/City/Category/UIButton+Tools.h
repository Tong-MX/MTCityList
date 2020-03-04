//
//  UIButton+Tools.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Tools)

+ (UIButton *)buttonWithTitle:(NSString *)title
                    titleFont:(CGFloat)titleFont
                   titleColor:(UIColor *)titleColor
              backgroundColor:(nullable UIColor *)backgroundColor
                       target:(id)target
                       action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
