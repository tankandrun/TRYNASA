//
//  APODModel.h
//  TRYNASA
//
//  Created by 金顺度 on 16/2/18.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APODModel : NSObject

@property (nonatomic,strong) NSString *copyright;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *explanation;
@property (nonatomic,strong) NSString *hdurl;
@property (nonatomic,strong) NSString *media_type;
@property (nonatomic,strong) NSString *service_version;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;

- (id)initWithDict:(NSDictionary *)dict;

@end
