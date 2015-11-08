//
//  AFUIViewCollectionAnimator.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/6/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFUIViewCollectionAnimator.h"

@implementation AFUIViewCollectionAnimator

+ (void)animateViews:(NSArray *)views totalDuration:(CGFloat)totalDuration maxDelayFactor:(CGFloat)maxDelayFactor animationBlock:(AFAnimationBlock)animationBlock {
    
    [AFUIViewCollectionAnimator animateViews:views totalDuration:totalDuration maxDelayFactor:maxDelayFactor order:AFCollectionAnimatorOrderAscending animationBlock:animationBlock];
}

+ (void)animateViews:(NSArray *)views totalDuration:(CGFloat)totalDuration maxDelayFactor:(CGFloat)maxDelayFactor order:(AFCollectionAnimatorOrder)order animationBlock:(AFAnimationBlock)animationBlock {
    
    if (maxDelayFactor < 0.0 || maxDelayFactor >= 1.0) {
        NSLog(@"AFUIViewCollectionAnimator animateViews: maxDelayFactor must be > 0 and <= 1. Aborting animation.");
        return;
    }
    
    NSMutableArray *arrayOfIndices;
    if (order == AFCollectionAnimatorOrderRandom) {
        arrayOfIndices = [NSMutableArray new];
        for (NSInteger i=0; i<views.count; i++) {
            [arrayOfIndices addObject:@(i)];
        }
        [AFUIViewCollectionAnimator shuffleArray:arrayOfIndices];
    }
    
    for (NSInteger index = 0; index < views.count; index++) {
        
        NSInteger orderOfAnimation;
        switch (order) {
            case AFCollectionAnimatorOrderAscending:
                orderOfAnimation = index;
                break;
            case AFCollectionAnimatorOrderDescending:
                orderOfAnimation = views.count - 1 - index;
                break;
            case AFCollectionAnimatorOrderRandom: {
                NSInteger randomIndex = arc4random_uniform((u_int32_t)arrayOfIndices.count);
                orderOfAnimation = [arrayOfIndices[randomIndex] integerValue];
                [arrayOfIndices removeObjectAtIndex:randomIndex];
            }
                break;
            default:
                break;
        }
        
        CGFloat delayFactor = maxDelayFactor * (orderOfAnimation / (views.count - 1.0));
        CGFloat durationFactor = 1.0 - delayFactor;
        CGFloat delay = delayFactor * totalDuration;
        CGFloat duration = durationFactor * totalDuration;
        
        UIView *view = views[index];
        if (animationBlock) {
            animationBlock(view, delay, duration);
        }
    }
    
}

+ (void)shuffleArray:(NSMutableArray *)array {
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
