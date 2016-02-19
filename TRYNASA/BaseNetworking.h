//
//  BaseNetworking.h
//  TRYNASA
//
//  Created by 金顺度 on 16/2/18.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetworking : NSObject

#define SUCCESSBLOCK void(^)(id successResponse)
#define FAILUREBLOCK void(^)(id failureResponse)

+ (void)GET:(NSString *)path parameters:(NSDictionary *)params success:(SUCCESSBLOCK)successBlock andFailure:(FAILUREBLOCK)failureBlock;

+ (void)POST:(NSString *)path parameters:(NSDictionary *)params success:(SUCCESSBLOCK)successBlock andFailure:(FAILUREBLOCK)failureBlock;

@end
