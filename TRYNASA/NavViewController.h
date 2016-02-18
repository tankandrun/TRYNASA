//
//  NavViewController.h
//  TestNavi
//
//  Created by 金顺度 on 16/1/8.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavViewController : UIViewController

@property (nonatomic,strong) UIViewController *currentViewController;

@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,assign) CGFloat navViewWidth;

@property (nonatomic,strong) NSArray *iconNameArray;
@property (nonatomic,strong) NSArray *rColorArray;
@property (nonatomic,strong) NSArray *bColorArray;
@property (nonatomic,strong) NSArray *gColorArray;

@end
