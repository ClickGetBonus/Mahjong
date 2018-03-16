//
//  CardSelectButtonCell.h
//  Mahjong
//
//  Created by Lan on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const ButtonCellWidth = 160;
static CGFloat const ButtonCellHeight = 44;

@interface CardSelectButtonCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *button;

@end
