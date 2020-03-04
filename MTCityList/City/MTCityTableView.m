//
//  MTCItyTableView.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityTableView.h"
#import "MTCityTableViewCell.h"
#import "MTHotCItyTableViewCell.h"

@interface MTCityTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray * dataList;

@end

@implementation MTCityTableView

+ (instancetype)tableViewPlainGroupedWithFrame:(CGRect)frame {
    MTCityTableView * tableView = [[self alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return tableView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedRowHeight = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section > 0) {
        return [_dataList[section] count];
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        MTHotCItyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHotCItyTableViewCell class])];
        if (!cell) {
            cell = [[MTHotCItyTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([MTHotCItyTableViewCell class])];
            cell.backgroundColor = COLOR_16(0x070707, 1);
        }
        return cell;
    }else {
        MTCityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTCityTableViewCell class])];
        if (!cell) {
            cell = [[MTCityTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([MTCityTableViewCell class])];
            cell.backgroundColor = COLOR_16(0x070707, 1);
              }
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.section);
    if (indexPath.section > 0 && _dataList.count > indexPath.section) {
        MTCityTableViewCell *baseCell = (MTCityTableViewCell *)cell;
        baseCell.model = _dataList[indexPath.section][indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 16 * 2 + 32 * 3 + 20;
    }else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

/**返回右侧索引所包含的内容*/
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_indexes.count > 0) {
        NSMutableArray *sections = [_indexes mutableCopy];
        [sections insertObject:UITableViewIndexSearch atIndex:0];
        [sections insertObject:@"热" atIndex:1];
        return sections;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customView = [UIView new];
    customView.frame = CGRectMake(0, 0, kScreenWidth, 25);
    customView.backgroundColor = COLOR_16(0x070707, 1);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.alpha = 0.5;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.frame = CGRectMake(16, 6, CGRectGetWidth(customView.frame), 17);
    if (_indexes.count > 0 && _dataList.count > 3) {
        titleLabel.text = section == 0 ? @"热门城市" : _indexes[section];
    }
    [customView addSubview:titleLabel];
    return customView;
}

//点击右侧索引后跳转到的section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index - 2;
}

- (void)setDataModel:(NSArray *)dataModel {
    _dataModel = dataModel;
    _dataList = [dataModel copy];
    [self reloadData];
}

@end
