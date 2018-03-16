//
//  CardSelectButtonCell.m
//  Mahjong
//
//  Created by Lan on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CardSelectButtonCell.h"

@interface CardSelectButtonCell()

@end

@implementation CardSelectButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.button.layer.cornerRadius = 10.0f;
    self.button.layer.masksToBounds = YES;
}

@end
