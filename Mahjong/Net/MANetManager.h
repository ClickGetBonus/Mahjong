//
//  MANetManager.h
//  Mahjong
//
//  Created by Lan on 2018/3/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAGame.h"
#import "GetGamesResponse.h"
#import "GetMenuResponse.h"
#import "MAMenu.h"

@interface MANetManager : NSObject

+ (void)requestGamesSuccess:(nullable void (^)(GetGamesResponse * _Nullable response))success
                    failure:(nullable void (^)(NSError * _Nonnull error))failure;


+ (void)requestMenuWithId:(NSString *)gameId
                  success:(nullable void (^)(GetMenuResponse * _Nullable response))success
                  failure:(nullable void (^)(NSError * _Nonnull error))failure;

@end
