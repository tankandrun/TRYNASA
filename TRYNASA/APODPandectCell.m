//
//  APODPandectCell.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/3.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "APODPandectCell.h"

@implementation APODPandectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bgImageView = [[CustonImageView alloc]init];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.label = [[UILabel alloc]init];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}


@end
