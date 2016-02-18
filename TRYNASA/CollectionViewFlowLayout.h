//
//  CollectionViewFlowLayout.h
//  TestSpringConllection
//
//  Created by 金顺度 on 16/1/27.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat springDamping;
@property (nonatomic, assign) CGFloat springFrequency;
@property (nonatomic, assign) CGFloat resistanceFactor;

@end
