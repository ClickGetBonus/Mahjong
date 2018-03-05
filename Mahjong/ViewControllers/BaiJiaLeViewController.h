//
//  BaiJiaLeViewController.h
//  Mahjong
//
//  Created by 贾卓峰 on 2017/9/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaiJiaLeViewController : UIViewController
    // 选择牌型
    @property(nonatomic,strong)NSArray * careTypeArr;
    @property(nonatomic,strong)NSArray * goodsPercentArr;
    
    // 全数据(类型)
    @property(nonatomic,strong)NSDictionary * myDataDic;
    
    
@end
