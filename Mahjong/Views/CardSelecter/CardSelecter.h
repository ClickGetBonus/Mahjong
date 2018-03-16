//
//  CardSelecter.h
//  Mahjong
//
//  Created by Lan on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAEnum.h"


typedef void(^ConfirmBlock)();
typedef void(^CancelBlock)();

@interface CardSelecter : UIView

@property (nonatomic, strong) ConfirmBlock confirmBlock;
@property (nonatomic, strong) CancelBlock cancelBlock;

@property(nonatomic, assign) NSInteger canSelectNum;

- (void)configureBy:(CardSelectType)type;


@end
