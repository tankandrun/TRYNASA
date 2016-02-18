//
//  CollectionViewFlowLayout.m
//  TestSpringConllection
//
//  Created by 金顺度 on 16/1/27.
//  Copyright © 2016年 金顺度. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@interface CollectionViewFlowLayout()

@property (nonatomic,strong) UIDynamicAnimator *animator;

@end

@implementation CollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.resistanceFactor = 500;
    }
    return self; 
}

- (void)setSpringDamping:(CGFloat)springDamping {
    if (springDamping>=0 && _springDamping!=springDamping) {
        _springDamping = springDamping;
        for (UIAttachmentBehavior *spring in self.animator.behaviors) {
            spring.damping = _springDamping;
        }
    }
}
- (void)setSpringFrequency:(CGFloat)springFrequency {
    if (springFrequency>=0 && _springFrequency!=springFrequency) {
        _springFrequency = springFrequency;
        for (UIAttachmentBehavior *spring in self.animator.behaviors) {
            spring.frequency = _springFrequency;
        }
    }
}

- (void)prepareLayout {
    [super prepareLayout];
    if (!self.animator) {
        self.animator = [[UIDynamicAnimator alloc]initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc]initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = self.springDamping;
            spring.frequency = self.springFrequency;
            
            [self.animator addBehavior:spring];
        }
    }
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y-scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in self.animator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceForTouch = fabs(touchLocation.y-anchorPoint.y);
        CGFloat scrollResistance = distanceForTouch/self.resistanceFactor;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        
        CGPoint center = item.center;
        center.y+=(scrollDelta>0)?MIN(scrollDelta, scrollDelta*scrollResistance):MAX(scrollDelta, scrollDelta*scrollResistance);
        item.center = center;
        [self.animator updateItemUsingCurrentState:item];
    }
    return NO;
}




@end
