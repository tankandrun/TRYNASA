//
//  NavViewController.m
//  TestNavi
//
//  Created by 金顺度 on 16/1/8.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "NavViewController.h"
#import "NavTableViewCell.h"
#import "HeaderView.h"

#import "APODCollectionViewController.h"

@interface NavViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *contentDetailView;
@property (nonatomic,strong) UIView *menuView;
@property (nonatomic,strong) NSArray *constraitsArray;
@property (nonatomic,strong) NSArray *controllers;
@property (nonatomic,assign) BOOL navOpening;
@property (nonatomic,assign) CGFloat firstX;

@end

@implementation NavViewController
- (NSArray *)controllers {
    if (!_controllers) {
        _controllers = @[@[@"APOD",[APODCollectionViewController class]]];
    }
    return _controllers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    UIView *navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    navView.clipsToBounds = YES;
    _navView = navView;
    
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    _contentView = contentView;
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.navViewWidth);
        make.top.bottom.mas_equalTo(0);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
    }];
    [self makeConstrains];
    
    UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, 64)];
    [_contentView addSubview:menuView];
    _menuView = menuView;
    
    UIButton *menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
    [menuBtn setTitle:@"三" forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:menuBtn];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:_navView.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = self.rowHeight;
    tableView.backgroundColor = [UIColor blackColor];
    tableView.separatorColor = [UIColor clearColor];
    tableView.bounces = NO;
    [_navView addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    //添加pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panning:)];
    [self.view addGestureRecognizer:pan];
    //设置第一个控制器
    APODCollectionViewController *apod = [[APODCollectionViewController alloc]init];
    [self setCurrentViewController:apod];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _contentDetailView.frame = self.view.bounds;
}
- (void)menuBtnClick {
    self.navOpening = !self.navOpening;
}
#pragma mark - pan手势
- (void)panning:(UIGestureRecognizer *)gestureRecgnizer {
    CGPoint point = [gestureRecgnizer locationInView:self.view];
    CGFloat length = point.x - _firstX;
    if (gestureRecgnizer.state == 1) {
        _firstX = point.x;
    }else if (gestureRecgnizer.state == 2) {
        if (_navOpening) {
            if (length>0) {
                length = 0;
            }else if (length < -self.navViewWidth) {
                length = -self.navViewWidth;
            }
            length = self.navViewWidth+length;
        }else {
            if (length<0) {
                length = 0;
            }else if (length > self.navViewWidth) {
                length = self.navViewWidth;
            }
        }
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(length);
            make.right.mas_equalTo(0);
        }];
        [self makeConstrains];
    }else if (gestureRecgnizer.state == 3) {
        CGFloat length = point.x - _firstX;
        if (_navOpening) {
            if (length<0) {
                self.navOpening = NO;
            }
        }else {
            if (length>0) {
                self.navOpening = YES;
            }
        }
    }
}
- (void)setNavOpening:(BOOL)navOpening {
    if (navOpening) {
        [self navOpend];
    }else {
        [self navClosed];
    }
    _navOpening = navOpening;
}
- (void)navOpend {
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_navView.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self makeConstrains];
    }];
}
- (void)navClosed {
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self makeConstrains];
    }];
}
#pragma mark - 设置控制器
- (void)setCurrentViewController:(UIViewController *)currentViewController {
    if (_currentViewController) {
        [self removeViewFromViewController:_currentViewController];
    }
    [self addViewFromViewController:currentViewController];
    _currentViewController = currentViewController;
}
- (void)removeViewFromViewController:(UIViewController *)vc {
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}
- (void)addViewFromViewController:(UIViewController *)vc {
    [self addChildViewController:vc];
    _contentDetailView = vc.view;
    [_contentView insertSubview:_contentDetailView belowSubview:_menuView];
    _contentDetailView.frame = self.view.bounds;
    _contentDetailView.autoresizingMask = UIViewAutoresizingNone;
}
//刷新布局需要
- (void)makeConstrains {
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NavTableViewCell *cell = [NavTableViewCell cellWithTableView:tableView];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256)/255 green:(float)arc4random_uniform(256)/255 blue:(float)arc4random_uniform(256)/255 alpha:1];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 300;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[HeaderView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = [[self.controllers[indexPath.row] lastObject] new];
    [self setCurrentViewController:vc];
    
    self.navOpening = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
