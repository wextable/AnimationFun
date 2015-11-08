//
//  AFUIViewCollectionAnimator.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/6/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AFAnimation.h"

typedef NS_ENUM(NSInteger, AFCollectionAnimatorOrder) {
    AFCollectionAnimatorOrderAscending,
    AFCollectionAnimatorOrderDescending,
    AFCollectionAnimatorOrderRandom,
    AFCollectionAnimatorOrderCount
};

typedef void(^AFAnimationBlock)(UIView *view, CGFloat delay, CGFloat duration);

@interface AFUIViewCollectionAnimator : NSObject

+ (void)animateViews:(NSArray *)views totalDuration:(CGFloat)totalDuration maxDelayFactor:(CGFloat)maxDelayFactor animationBlock:(AFAnimationBlock)animationBlock;
+ (void)animateViews:(NSArray *)views totalDuration:(CGFloat)totalDuration maxDelayFactor:(CGFloat)maxDelayFactor order:(AFCollectionAnimatorOrder)order animationBlock:(AFAnimationBlock)animationBlock;

@end
