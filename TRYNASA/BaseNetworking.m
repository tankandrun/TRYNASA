//
//  BaseNetworking.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/18.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "BaseNetworking.h"

static AFHTTPSessionManager *manager = nil;

@implementation BaseNetworking

+ (AFHTTPSessionManager *)shareAFManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain",@"application/x-javascript", nil];
    });
    return manager;
}

+ (void)POST:(NSString *)path parameters:(NSDictionary *)params success:(void (^)(id))successBlock andFailure:(void (^)(id))failureBlock {
    manager.requestSerializer.timeoutInterval = 20.0;
    
    [[self shareAFManager] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

+ (void)GET:(NSString *)path parameters:(NSDictionary *)params success:(void (^)(id))successBlock andFailure:(void (^)(id))failureBlock {
    manager.requestSerializer.timeoutInterval = 20.0;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
    [[self shareAFManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                successBlock(result);
            }
        }else {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}




@end
