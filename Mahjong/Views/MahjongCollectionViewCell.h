//
//  MahjongCollectionViewCell.h
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGame.h"

@interface MahjongCollectionViewCell : UICollectionViewCell

-(void)configureDataWite:(id)data;

- (void)configureBy:(MAGame *)game;

@end
