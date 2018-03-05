//
//  NSString+Tools.m
//  Vogue
//
//  Created by Lee on 7/18/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "NSString+Tools.h"
#import "SSKeychain.h"

@implementation NSString (Tools)

+ (NSString *)timeStamp
{
    NSString *timeStampStr = [NSString stringWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    return timeStampStr;
}

+ (NSString *)deviceUUID
{
    static NSString * __udid = nil;
    if ( nil == __udid )
    {
        NSString * udid = [SSKeychain passwordForService:[self appIdentifier] account:@"udid"];
        if (!udid) {
            udid = [[UIDevice currentDevice].identifierForVendor UUIDString];
            [SSKeychain setPassword:udid forService:[self appIdentifier] account:@"udid"];
        }
        __udid = udid;
    }

    return __udid;
    
   
}



+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    //    NSString * timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        // 时间为今天
        NSTimeInterval late = beTime*1;
        
        NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now = [dat timeIntervalSince1970]*1;
        NSString *timeString = @"";
        
        NSTimeInterval cha = fabs(now-late);
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
        
        distanceStr = timeString;
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = @"昨天";
            //            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
    }
    else if(distanceTime<24*60*60*3 && [nowDay integerValue] - 1 != [lastDay integerValue]){//前天
        if ([nowDay integerValue] - [lastDay integerValue] == 2 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 2))
        {
            distanceStr = @"前天";
        }else{
            [df setDateFormat:@"MM-dd"];
            distanceStr = [df stringFromDate:beDate];
        }
    }
    else if(distanceTime <24*60*60*365){
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        NSDateComponents *oldDateComponent = [calendar components:unitFlags fromDate:beDate];
        if (dateComponent.year == oldDateComponent.year) {
            [df setDateFormat:@"MM-dd"];
        }else{
            [df setDateFormat:@"yyyy-MM-dd"];
        }
        
        distanceStr = [df stringFromDate:beDate];
    }else{
        
        [df setDateFormat:@"yyyy-MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

+ (NSString *)appIdentifier
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    static NSString * __identifier = nil;
    if ( nil == __identifier )
    {
        __identifier = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] copy];
    }
    return __identifier;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return @"";
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

@end
