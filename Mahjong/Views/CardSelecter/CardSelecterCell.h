//
//  CardSelecterCell.h
//  Mahjong
//
//  Created by Lan on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAEnum.h"
#import "Card.h"

static CGFloat const CardSlecterCellHeight = 40;
static CGFloat const CardSlecterCellRatio = 0.686;

@interface CardSelecterCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) Card *card;

@end
