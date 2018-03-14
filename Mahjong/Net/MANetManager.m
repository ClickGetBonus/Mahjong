//
//  MANetManager.m
//  Mahjong
//
//  Created by Lan on 2018/3/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MANetManager.h"
#import <MJExtension.h>

@implementation MANetManager

+ (void)requestGet:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id  _Nullable responseObject))success
           failure:(void (^)(NSError * _Nonnull))failure {
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:urlString
      parameters:parameters
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求成功");
            NSLog(@"%@",responseObject);
            if (success != nil) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
            NSLog(@"Error: %@", error);
            
            if (failure != nil) {
                failure(error);
            }
        }];
}

+ (void)requestGamesSuccess:(nullable void (^)(GetGamesResponse * _Nullable response))success
                    failure:(nullable void (^)(NSError * _Nonnull error))failure
 {
     
     [self requestGet:@"http://www.dingweiyun.net/dszw/index.php"
           parameters:@{@"m":@"game"}
              success:^(id  _Nullable responseObject) {
                  
                  GetGamesResponse *response = [GetGamesResponse mj_objectWithKeyValues:responseObject];
                  if (success != nil) {
                      success(response);
                  }
              } failure:^(NSError * _Nonnull error) {
                  
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

+ (void)requestMenuWithId:(NSString *)gameId
                  success:(nullable void (^)(GetMenuResponse * _Nullable response))success
                  failure:(nullable void (^)(NSError * _Nonnull error))failure
{
    
    [self requestGet:@"http://www.dingweiyun.net/dszw/index.php"
          parameters:@{@"m":@"menu",
                       @"id":gameId}
             success:^(id  _Nullable responseObject) {
                 
                 GetMenuResponse *response = [GetMenuResponse mj_objectWithKeyValues:responseObject];
                 if (success != nil) {
                     success(response);
                 }
             } failure:^(NSError * _Nonnull error) {
                 
                 if (failure != nil) {
                     failure(error);
                 }
             }];
}


@end
