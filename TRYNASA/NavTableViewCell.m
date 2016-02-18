//
//  NavTableViewCell.m
//  TestNavi
//
//  Created by 金顺度 on 16/1/8.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "NavTableViewCell.h"
#import <Masonry.h>

@implementation NavTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    NavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NavTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        _iconView = iconView;
    }
    return self;
}

@end
