//
//  GeneralCell.m
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "GeneralCell.h"


typedef NS_ENUM(NSInteger, GeneralCellType) {
    GeneralCellTypeTextField,
    GeneralCellTypeSinglePicker,
    GeneralCellTypeSwitch,
    GeneralCellTypeSwitchAndPicker,
};


@implementation GeneralCell

- (instancetype)initWithType:(GeneralCellType)type {
    
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever"];
}



@end
