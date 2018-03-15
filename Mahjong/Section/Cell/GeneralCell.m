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
@property(nonatomic, strong) UIButton *pickButton;
@property(nonatomic, strong) UITextField *textField;


@end

@implementation GeneralCell

- (instancetype)initTextFieldTypeWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"]) {
        
        self.type = GeneralCellTypeTextField;
        
        [self initTitleLabel];
        self.title = title;
        self.titleLabel.text = title;
        
        [self initTextField];
        self.textField.placeholder = placeholder;
    }
    return self;
}


- (instancetype)initSinglePickTypeWithTitle:(NSString *)title  pickData:(NSArray <NSString *> *)pickData {
   
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"]) {
        
        self.type = GeneralCellTypeSinglePicker;
        
        [self initTitleLabel];
        self.title = title;
        self.titleLabel.text = title;
        
        [self initPickButton];
        if ([pickData isKindOfClass:[NSArray class]]) {
            self.pickData = pickData;
            if (pickData.count >= 1) {
                [self.pickButton setTitle:pickData.firstObject forState:UIControlStateNormal];
            }
        } else {
            self.pickData = @[];
        }
        
        
        
    }
    return self;
}

- (instancetype)initSwitchWithTitle:(NSString *)title {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"]) {
        
        self.type = GeneralCellTypeSwitch;
        
        [self initTitleLabel];
        self.title = title;
        self.titleLabel.text = title;
        
        [self initSwitch];
        [self.switcher setOn:NO];
    }
    
    return self;
}

- (instancetype)initSwitchAndPickTypeWithTitle:(NSString *)title pickData:(NSArray <NSString *> *)pickData {
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever, not use"]) {
        
        self.type = GeneralCellTypeSwitchAndPicker;
        
        [self initTitleLabel];
        self.title = title;
        self.titleLabel.text = title;
        
        [self initSwitchAndPick];
        [self.switcher setOn:NO];
        if ([pickData isKindOfClass:[NSArray class]]) {
            self.pickData = pickData;
            if (pickData.count >= 1) {
                [self.pickButton setTitle:pickData.firstObject forState:UIControlStateNormal];
            }
        } else {
            self.pickData = @[];
        }
        
    }
    
    return self;
}

- (void)initTitleLabel {
    
    if (self.titleLabel != nil) {
        return;
    }
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, generalCellHeight)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    __weak typeof(self) weakSelf = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.height.mas_equalTo(generalCellHeight);
        make.top.equalTo(weakSelf.contentView);
        make.width.equalTo(@100);
    }];
}


- (void)initTextField {
    
    if (self.textField != nil) {
        return;
    }
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.textColor = [UIColor blackColor];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.textField];
    
    __weak typeof(self) weakSelf = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(15);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
    }];
}

- (void)initSwitch {
    
    if (self.switcher != nil) {
        return;
    }
    
    self.switcher = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
    [self.switcher addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switcher];
    
    __weak typeof(self) weakSelf = self;
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(31);
    }];
}


- (void)initPickButton {
    
    if (self.pickButton != nil) {
        return;
    }
    
    self.pickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pickButton.layer.cornerRadius = 3;
    self.pickButton.layer.borderWidth = 0.5;
    [self.pickButton setTitleColor:UIColorRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.pickButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.pickButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    self.pickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.pickButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.pickButton addTarget:self action:@selector(onPick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.pickButton];
    
    __weak typeof(self) weakSelf = self;
    [self.pickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(15);
        make.height.mas_equalTo(30);
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}

- (void)initSwitchAndPick {
    
    if (self.switcher != nil || self.pickButton != nil) {
        return;
    }
    
    self.switcher = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
    [self.switcher addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switcher];
    
    __weak typeof(self) weakSelf = self;
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(15);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(31);
    }];
    
    self.pickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pickButton.layer.cornerRadius = 3;
    self.pickButton.layer.borderWidth = 0.5;
    self.pickButton.layer.borderColor = UIColorRGB(0xCCCCCC).CGColor;
    [self.pickButton setTitleColor:UIColorRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.pickButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.pickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.pickButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.pickButton addTarget:self action:@selector(onPick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.pickButton];
    
    [self.pickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.switcher.mas_right).with.offset(15);
        make.height.mas_equalTo(30);
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}



- (void)setContent:(NSString *)content {
    switch (self.type) {
        case GeneralCellTypeTextField:
            self.textField.text = content;
            break;
        case GeneralCellTypeSinglePicker:
        case GeneralCellTypeSwitchAndPicker:
            [self.pickButton setTitle:content forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)turnOn:(BOOL)isOn {
    switch (self.type) {
        case GeneralCellTypeSwitch:
        case GeneralCellTypeSwitchAndPicker:
        case GeneralCellTypePokerSelect:
        case GeneralCellTypeMahjongSelect:
            [self.switcher setOn:isOn];
            break;
        default:
            break;
    }
}


- (void)onPick {
    self.pickBlock();
}

- (void)onSwitch {
    self.switchBlock(self.switcher.isOn, self.index);
}

@end
