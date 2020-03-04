//
//  ViewController.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "ViewController.h"
#import "MTCityManager.h"
#import "MTCityViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MTCityManager writeProvinceCityToFile];
    UIButton *btn = [UIButton buttonWithTitle:@"开始" titleFont:14 titleColor:[UIColor whiteColor] backgroundColor:COLOR_16(0x141313, 1) target:self action:@selector(clickAction)];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
}

- (void)clickAction {
    MTCityViewController *controller = [[MTCityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
