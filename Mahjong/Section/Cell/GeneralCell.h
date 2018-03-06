//
//  GeneralCell.h
//  Mahjong
//
//  Created by Lan on 2018/3/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAEnum.h"


@interface GeneralCell : UITableViewCell



- (instancetype)initWithType:(GeneralCellType)type title:(NSString *)title pickData:(NSArray <NSString *> *)pickData;

@end
