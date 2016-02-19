//
//  APODModel.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/18.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "APODModel.h"

@implementation APODModel
- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.copyright = [NSString stringWithFormat:@"%@",dict[@"copyright"]];
        self.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
        self.explanation = [NSString stringWithFormat:@"%@",dict[@"explanation"]];
        self.hdurl = [NSString stringWithFormat:@"%@",dict[@"hdurl"]];
        self.media_type = [NSString stringWithFormat:@"%@",dict[@"media_type"]];
        self.service_version = [NSString stringWithFormat:@"%@",dict[@"service_version"]];
        self.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
        self.url = [NSString stringWithFormat:@"%@",dict[@"url"]];
    }
    return self;
}

@end
