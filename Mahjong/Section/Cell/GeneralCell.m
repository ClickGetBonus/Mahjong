//
//  GeneralCell.m
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "GeneralCell.h"
#import <Masonry.h>

static CGFloat generalCellHeight = 40.0f;

@interface GeneralCell()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UISwitch *switcher;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UITextField *textField;

@property(nonatomic, strong) NSArray <NSString *> *pickData;

@end

@implementation GeneralCell

- (instancetype)initTextFieldTypeWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    
    [self initTitleLabel];
    self.titleLabel.text = title;
    
    [self initTextField];
    self.textField.placeholder = placeholder;
    
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"];
}


- (instancetype)initSinglePickTypeWithTitle:(NSString *)title pickData:(NSArray <NSString *> *)pickData {
    
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"];
}

- (instancetype)initSwitchWithTitle:(NSString *)title {
    
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"];
}

- (instancetype)initSwitchAndPickTypeWithTitle:(NSString *)title pickData:(NSArray <NSString *> *)pickData {
    
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"];
}

- (void)initTitleLabel {
    
    if (self.titleLabel != nil) {
        return;
    }
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, generalCellHeight)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.height.mas_equalTo(generalCellHeight);
        make.top.equalTo(self.contentView.mas_top);
    }];
}


- (void)initTextField {
    
    if (self.textField != nil) {
        return;
    }
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).with.offset(15);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
}

- (void)initSwitch {
    
    if (self.switcher != nil) {
        return;
    }
    
    self.switcher = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
    [self.contentView addSubview:self.switcher];
    
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
}


- (void)initPickButton {
    
    if (self.button != nil) {
        return;
    }
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.layer.cornerRadius = 3;
    self.button.layer.borderWidth = 0.5;
    self.button.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.button addTarget:self action:@selector(onPick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).with.offset(15);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
}




- (void)onPick {
    
}


@end
