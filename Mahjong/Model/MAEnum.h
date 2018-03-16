//
//  MAEnum.h
//  Mahjong
//
//  Created by Aki on 2018/3/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#ifndef MAEnum_h
#define MAEnum_h


typedef enum : NSUInteger {
    GeneralCellTypeTextField = 1,         //文本
    GeneralCellTypeSwitch,            //开关
    GeneralCellTypeSinglePicker,      //单选列表
    GeneralCellTypeSwitchAndPicker,   //开关+单选列表
    GeneralCellTypeMahjongSelect,     //麻将选牌
    GeneralCellTypePokerSelect,       //扑克选牌
    GeneralCellTypeRun,               //跑胡子选牌
} GeneralCellType;

typedef enum: NSUInteger {
    CardSelectTypePoker,  //扑克
    CardSelectTypeMahjong,   //麻将
    CardSelectTypeBeard,     //跑胡子
}CardSelectType;

typedef enum: NSUInteger {
    CardTypePokerDiamond,  //扑克方块
    CardTypePokerClub,     //扑克梅花
    CardTypePokerHeart,    //扑克红心
    CardTypePokerSpades,   //扑克黑桃
    CardTypePokerJoker,    //扑克鬼牌
    CardTypeMahjongTong,   //麻将筒
    CardTypeMahjongWan,    //麻将万
    CardTypeMahjongSuo,    //麻将索
    CardTypeMahjongZi,     //麻将字
    CardTypeBeardNum,      //跑胡子数字
    CardTypeBeardWord,     //跑胡子大字
}CardType;


#endif /* MAEnum_h */
