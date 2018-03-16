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

static NSTimeInterval const FlipCardIntercal = 0.6f;

static CGFloat const CardSlecterCellPokerHeight = 60;
static CGFloat const CardSlecterCellPokerRatio = 0.686;

static CGFloat const CardSlecterCellMahjongHeight = 60;
static CGFloat const CardSlecterCellMahjongRatio = 0.686;

static CGFloat const CardSlecterCellBeardHeight = 80;
static CGFloat const CardSlecterCellBeardRatio = 0.25;



@interface CardSelecterCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) Card *card;

- (void)flipCard;

@end
