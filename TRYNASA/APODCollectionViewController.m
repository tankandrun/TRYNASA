//
//  APODCollectionViewController.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/2.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "APODCollectionViewController.h"
#import "CollectionViewFlowLayout.h"
#import "APODPandectCell.h"
#import "APODModel.h"
#import <MJExtension.h>

@interface APODCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) CollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *mainCollectionView;

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) APODModel *apodModel;

@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation APODCollectionViewController
- (NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (CollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[CollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 200);
        _flowLayout.minimumLineSpacing = 5;
    }
    return _flowLayout;
}
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mainCollectionView];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
    }
    return _mainCollectionView;
}
- (NSString *)getDateFromNowDays:(int)days {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24*days]];
    return date;
}
#pragma mark - 页面加载相关
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.flowLayout.springDamping = 1;
    self.flowLayout.springFrequency = 1;
    self.mainCollectionView.hidden = NO;
    [self.mainCollectionView registerClass:[APODPandectCell class] forCellWithReuseIdentifier:@"cell"];
    
    [BaseNetworking GET:@"https://api.nasa.gov/planetary/apod?api_key=up28YO9Q5UdjH4ErFlM2CLX1QMc8P0CVs22fmR5B" parameters:nil success:^(id successResponse) {
        NSLog(@"%@",successResponse);
        self.apodModel = [[APODModel alloc]initWithDict:successResponse];
        [self.modelArray addObject:self.apodModel];
        
        for (int i = 0; i<20; i++) {
            [BaseNetworking GET:@"https://api.nasa.gov/planetary/apod?api_key=up28YO9Q5UdjH4ErFlM2CLX1QMc8P0CVs22fmR5B" parameters:@{@"date":[self getDateFromNowDays:i+1]} success:^(id successResponse) {
                NSLog(@"%@",successResponse);
                self.apodModel = [[APODModel alloc]initWithDict:successResponse];
                [self.modelArray addObject:self.apodModel];
                if (i == 19) {
                    [self.mainCollectionView reloadData];
                }
            } andFailure:^(id failureResponse) {
                NSLog(@"%@",failureResponse);
            }];
        }
        
    } andFailure:^(id failureResponse) {
        
    }];
    
    
    
    
    
}




#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APODPandectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.modelArray.count != 0) {
        APODModel *model = self.modelArray[indexPath.row];
        [cell.bgImageView.imageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
        cell.label.text = model.title;
    }
    cell.contentView.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
