//
//  CHessViewController.h
//  Mahjong
//
//  Created by 贾卓峰 on 2017/4/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

//棋牌
@interface CHessViewController : UIViewController

// 选择牌型
@property(nonatomic,strong)NSArray * careTypeArr;
// 选择好牌几率
@property(nonatomic,strong)NSArray * goodsPercentArr;
// 跑得快
@property(nonatomic,strong)NSArray * runFastArr;
// 跑胡子
@property(nonatomic,strong)NSArray * runBeardArr;
// 全数据(类型)
@property(nonatomic,strong)NSDictionary * myDataDic;

@end
