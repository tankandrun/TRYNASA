//
//  APODCollectionViewController.m
//  TRYNASA
//
//  Created by 金顺度 on 16/2/2.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "APODCollectionViewController.h"
#import "CollectionViewFlowLayout.h"

@interface APODCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) CollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *mainCollectionView;



@end

@implementation APODCollectionViewController
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
    [self.mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    return cell;
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
