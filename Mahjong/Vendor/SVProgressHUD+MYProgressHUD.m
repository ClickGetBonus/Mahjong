//
//  SVProgressHUD+MYProgressHUD.m
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SVProgressHUD+MYProgressHUD.h"

@implementation SVProgressHUD (MYProgressHUD)

+(void)showProgressDuration:(CGFloat)time{

    [[self class] show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[self class] dismiss];
    });
    
}

@end
