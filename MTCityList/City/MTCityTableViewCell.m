//
//  MTCItyTableViewCell.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTCityTableViewCell.h"

@interface MTCityTableViewCell ()

@property (nonatomic, weak) UILabel *cityLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation MTCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
        [self addViewsConstraints];
    }
    return self;
}

- (void)addViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *cityLabel = [[UILabel alloc] init];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.font = [UIFont systemFontOfSize:12];
    cityLabel.numberOfLines = 0;
    [self.contentView addSubview:cityLabel];
    _cityLabel = cityLabel;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = COLOR_16(0x180F12, 0.06);
    [self.contentView addSubview:lineView];
    _lineView = lineView;
}

- (void)addViewsConstraints {
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView).offset(16);
           make.centerY.equalTo(self.contentView);
       }];
       
       [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_cityLabel);
           make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
           make.right.equalTo(self.contentView).offset(-8);
           make.height.mas_equalTo(1);
       }];
}

- (void)clickAction:(UIButton *)btn {
    
}

- (void)setModel:(MTCityModel *)model {
    _model = model;
    _cityLabel.text = model.name;
}
@end
