//
//  UIView+AFAnimation.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AFAnimationType) {
    AFAnimationTypeSpin,
    AFAnimationTypePulse,
    AFAnimationTypeSlide,
    AFAnimationTypeCount
};

typedef NS_ENUM(NSInteger, AFAnimationOffscreenPosition) {
    AFAnimationOffscreenPositionTop,
    AFAnimationOffscreenPositionBottom,
    AFAnimationOffscreenPositionLeft,
    AFAnimationOffscreenPositionRight,
    AFAnimationOffscreenPositionRandom,
    AFAnimationOffscreenPositionCount
};

@interface UIView (AFAnimation)

- (void)spinUpView;
- (void)spinUpViewWithDelay:(CGFloat)delay duration:(CGFloat)duration;
- (void)spinDownView;
- (void)spinDownViewWithDelay:(CGFloat)delay duration:(CGFloat)duration;

- (void)pulseGrowView;
- (void)pulseGrowViewWithDelay:(CGFloat)delay duration:(CGFloat)duration;
- (void)pulseShrinkView;
- (void)pulseShrinkViewWithDelay:(CGFloat)delay duration:(CGFloat)duration;

- (void)slideViewInFromOffscreenPosition:(AFAnimationOffscreenPosition)position;
- (void)slideViewInFromOffscreenPosition:(AFAnimationOffscreenPosition)position delay:(CGFloat)delay duration:(CGFloat)duration;
- (void)slideViewOutToOffscreenPosition:(AFAnimationOffscreenPosition)position;
- (void)slideViewOutToOffscreenPosition:(AFAnimationOffscreenPosition)position delay:(CGFloat)delay duration:(CGFloat)duration;

@end
