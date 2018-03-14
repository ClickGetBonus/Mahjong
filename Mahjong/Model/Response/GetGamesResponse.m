//
//  GetGamesResponse.m
//  Mahjong
//
//  Created by Lan on 2018/3/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "GetGamesResponse.h"
#import <MJExtension.h>

@implementation GetGamesResponse

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data" : @"MAGame"};
}

@end
