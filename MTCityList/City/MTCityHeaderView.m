//
//  MTCityHeaderView.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityHeaderView.h"

@interface MTCityHeaderView () <UISearchBarDelegate>

@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation MTCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addViews];
        [self addViewsConstraints];
    }
    
    return self;
}

- (void)addViews {
    self.backgroundColor = COLOR_16(0x070707, 1);
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索城市名称";
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.tintColor = [UIColor whiteColor];
    
    UITextField *SearchBarTextField = [searchBar valueForKey:@"searchField"];
    SearchBarTextField.backgroundColor = COLOR_16(0x141313, 1);
    SearchBarTextField.layer.masksToBounds = YES;
    SearchBarTextField.layer.cornerRadius = 32/2;
    SearchBarTextField.font = [UIFont systemFontOfSize:14];
    SearchBarTextField.textColor = [UIColor whiteColor];
    
    [searchBar setImage:[UIImage imageNamed:@"icon_mine_city_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    
    [self addSubview:searchBar];
    _searchBar = searchBar;
}

- (void)addViewsConstraints {
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(6);
        make.right.offset(-6);
        make.top.offset(10);
        make.height.mas_equalTo(32);
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@,%@",searchBar.text,searchText);
//    [self safePerformAction:@"searchTextDidChange_cityheaderView:" withObject:searchText];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    UITextField * searchBarTextField = [searchBar valueForKey:@"searchField"];
    [searchBarTextField resignFirstResponder];
}

@end
