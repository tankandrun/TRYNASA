//
//  NavTableViewCell.h
//  TestNavi
//
//  Created by 金顺度 on 16/1/8.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) UIImageView *iconView;

@end
