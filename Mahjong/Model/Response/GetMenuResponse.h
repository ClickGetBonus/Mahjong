//
//  GetMenuResponse.h
//  Mahjong
//
//  Created by Lan on 2018/3/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMenu.h"

@interface GetMenuResponse : NSObject

@property (copy, nonatomic) NSArray<MAMenu *> *data;
@property (strong, nonatomic) NSNumber *version;

@end
