//
//  GeneralDetailVC.h
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGame.h"

@interface GeneralDetailVC : UITableViewController

- (instancetype)initWithCellTypes:(NSArray *)types;

- (instancetype)initWithGame:(MAGame *)game;

@end
