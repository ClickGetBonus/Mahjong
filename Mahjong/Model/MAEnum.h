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
    GeneralCellTypeTextField,         //文本
    GeneralCellTypeSwitch,            //开关
    GeneralCellTypeSinglePicker,      //单选列表
    GeneralCellTypeSwitchAndPicker,   //开关+单选列表
    GeneralCellTypeMahjongSelect,     //麻将选牌
    GeneralCellTypePokerSelect,       //扑克选牌
    GeneralCellTypeRun,               //跑胡子选牌
} GeneralCellType;

#endif /* MAEnum_h */
