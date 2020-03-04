//
//  MTHotCItyTableViewCell.m
//  MTCityList
//
//  Created by 桐 on 2020/3/4.
//  Copyright © 2020 com.mt.citylist. All rights reserved.
//

#import "MTHotCItyTableViewCell.h"

@interface MTHotCItyTableViewCell ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@end
@implementation MTHotCItyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
        [self addViewsConstraints];
    }
    return self;
}

- (void)addViews {
    NSArray<NSString *> *titles = @[@"上海市",
                                    @"杭州市",
                                    @"北京市",
                                    @"广州市",
                                    @"天津市",
                                    @"南京市",
                                    @"武汉市",
                                    @"苏州市",
                                    @"福州市"];
    
    _buttons = [NSMutableArray array];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithTitle:obj titleFont:14 titleColor:[UIColor whiteColor] backgroundColor:COLOR_16(0x141313, 1) target:self action:@selector(clickAction:)];
        [self addSubview:btn];
        [_buttons addObject:btn];
    }];
}

- (void)addViewsConstraints {
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (idx == 0 || idx%3 == 0) {
                make.left.equalTo(self.contentView).offset(16);
                if (idx == 0) {
                    make.top.equalTo(self.contentView).offset(13);
                }else {
                    make.top.equalTo(_buttons[idx - 1].mas_bottom).offset(10);
                }
            }else {
                make.left.equalTo(_buttons[idx - 1].mas_right).offset(12);
                make.centerY.equalTo(_buttons[idx - 1].mas_centerY);
            }
            make.size.mas_equalTo(CGSizeMake(105, 32));
        }];
    }];
}

- (void)clickAction:(UIButton *)btn {
    
}
@end
