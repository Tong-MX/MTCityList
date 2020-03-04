//
//  ILYCityViewController.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityViewController.h"
#import "MTCityTableView.h"
#import "MTCityHeaderView.h"

@interface MTCityViewController ()

@property (nonatomic, strong) MTCityHeaderView *cityHeaderView;
@property (nonatomic, weak) MTCityTableView *cityTableView;

@property (nonatomic, strong) NSMutableArray *cityIndexes;
@property (nonatomic, strong) NSMutableArray *citys;

@end

@implementation MTCityViewController

- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self loadData];
}

- (void)initData {
    self.title = @"城市";
    self.navigationController.navigationBar.barTintColor = COLOR_16(0x070707, 1);
}

- (void)initView {
    MTCityTableView *cityTableView = [MTCityTableView tableViewPlainGroupedWithFrame:CGRectZero];
    cityTableView.backgroundColor =  COLOR_16(0x070707, 1);
    cityTableView.tableHeaderView = self.cityHeaderView;
    cityTableView.sectionIndexColor = COLOR_16(0x180F12, 0.5);
    cityTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    cityTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    cityTableView.sectionIndexMinimumDisplayRowCount = 13;
    cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:cityTableView];
    _cityTableView = cityTableView;

    [cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.offset(kNavBarHeight);
    }];

}

- (void)loadData {
    [self.cityIndexes addObjectsFromArray:[MTCityManager getCityFirstLetter]];
        [self.cityIndexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.citys addObject:[MTCityManager getCityWithFirstLetter:obj]];
        }];
    [self.cityIndexes insertObject:@"" atIndex:0];
    [self.citys insertObject:@"" atIndex:0];
    
    self.cityTableView.indexes = self.cityIndexes;
    self.cityTableView.dataModel = self.citys;
}

- (MTCityHeaderView *)cityHeaderView {
    if (!_cityHeaderView) {
        _cityHeaderView = [[MTCityHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32 + 27)];
    }
    return _cityHeaderView;
}

- (NSMutableArray *)citys {
    if (!_citys) {
        _citys = [NSMutableArray array];
    }
    return _citys;
}

- (NSMutableArray *)cityIndexes {
    if (!_cityIndexes) {
        _cityIndexes = [NSMutableArray array];
    }
    return _cityIndexes;
}
@end
