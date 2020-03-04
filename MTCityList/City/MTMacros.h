//
//  MTMacros.h
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#ifndef MTMacros_h
#define MTMacros_h

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define COLOR_16(x,a) [UIColor colorWithRed:((float)((x & 0xFF0000) >> 16)) / 255.0 green:((float)((x & 0xFF00) >> 8)) / 255.0 blue:((float)(x & 0xFF)) / 255.0 alpha:a]

//iPhoneX / iPhoneXS
#define  kIsIPhoneXOrXS (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  kIsIPhoneXROrXMax (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)

#define  kIsIPhoneX    (kIsIPhoneXOrXS || kIsIPhoneXROrXMax)
// 适配iPhone X 状态栏高度
#define  kStatusBarHeight      (kIsIPhoneX ? 44.f : 20.f)
// 适配iPhone X Tabbar高度
#define  kTabBarHeight         (kIsIPhoneX ? (49.f+34.f) : 49.f)
// 适配iPhone X Tabbar距离底部的距离
#define  kTabBarSafeBottomMargin         (kIsIPhoneX ? 34.f : 0.f)

#define  kNavBarHeight          (44.f + kStatusBarHeight)
#endif /* MTMacros_h */
