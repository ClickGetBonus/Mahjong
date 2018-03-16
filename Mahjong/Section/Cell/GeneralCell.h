//
//  GeneralCell.h
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAEnum.h"


typedef void(^PickBlock)();
typedef void(^SwitchBlock)(BOOL, NSUInteger);



@interface GeneralCell : UITableViewCell

- (instancetype)initTextFieldTypeWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

- (instancetype)initSinglePickTypeWithTitle:(NSString *)title pickData:(NSArray <NSString *> *)pickData;

- (instancetype)initSwitchWithTitle:(NSString *)title;

- (instancetype)initSwitchAndPickTypeWithTitle:(NSString *)title pickData:(NSArray <NSString *> *)pickData;

- (void)setContent:(NSString *)content;
- (void)turnOn:(BOOL)isOn;

@property(nonatomic, strong) PickBlock pickBlock;
@property(nonatomic, strong) SwitchBlock switchBlock;
@property(nonatomic, assign) GeneralCellType type;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray <NSString *> *pickData;
@property(nonatomic, assign) BOOL isOn;
@property(nonatomic, assign) NSUInteger index;



@end
