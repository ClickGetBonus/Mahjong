//
//  NSString+Tools.h
//  Vogue
//
//  Created by Lee on 7/18/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface NSString (Tools)

+ (NSString *)timeStamp;
+ (NSString *)deviceUUID;

/**
 格式化时间戳

 @param beTime <#beTime description#>
 @return <#return value description#>
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

@end
