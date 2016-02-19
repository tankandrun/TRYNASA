
//
//  CustonImageView.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/18.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "CustonImageView.h"

@implementation CustonImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init {
    if (self = [super init]) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        _imageView.contentMode = 2;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.clipsToBounds = YES;
    }
    return self;
}

@end
