//
//  AFCircleTransitionObject.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFCircleTransitionObject.h"


#define TRANSITION_DURATION 0.4


@interface AFCircleTransitionObject ()
@property (strong, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (strong, nonatomic) UIView *buttonSnapshot;
@end


@implementation AFCircleTransitionObject

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  TRANSITION_DURATION;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    UIView *container = [transitionContext containerView];
    UIView *fromView = [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] view];
    UIView *toView = [[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] view];
    
    
    CGFloat w = container.frame.size.width;
    CGFloat h = container.frame.size.height;
    CGFloat diameter = sqrtf(w*w + h*h) * 2.0;
    
    CGRect smallFrame = self.launchingView.frame;
    
    CGFloat x = smallFrame.origin.x + smallFrame.size.width / 2.0;
    CGFloat y = smallFrame.origin.y + smallFrame.size.height / 2.0;
    
    CGRect bigFrame = CGRectMake(x - diameter/2.0, y - diameter/2.0, diameter, diameter);
    
    
    if (!self.reversing) {
        
        self.buttonSnapshot = [self.launchingView snapshotViewAfterScreenUpdates:NO];
        self.buttonSnapshot.frame = CGRectOffset(self.launchingView.frame, 0, 0);
        
        [container addSubview:toView];
        [container addSubview:self.buttonSnapshot];

        
        [self animatePathInContainer:container
                              launchedView:toView
                          startFrame:smallFrame
                            endFrame:bigFrame];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.25
                         animations:^{
            
                             self.buttonSnapshot.transform = CGAffineTransformMakeScale(0.01, 0.01);
                             self.buttonSnapshot.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self.buttonSnapshot removeFromSuperview];
        }];
        
        
    } else {
        
        self.buttonSnapshot.transform = CGAffineTransformMakeScale(0, 0);
        self.buttonSnapshot.alpha = 0;
        
        [container insertSubview:toView belowSubview:fromView];
        [container addSubview:self.buttonSnapshot];

        
        [self animatePathInContainer:container
                        launchedView:fromView
                          startFrame:bigFrame
                            endFrame:smallFrame];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.9
                              delay:[self transitionDuration:transitionContext] * 0.1
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            
                             self.buttonSnapshot.transform = CGAffineTransformIdentity;
                             self.buttonSnapshot.alpha = 1;
            
        } completion:^(BOOL finished) {            
            [self.buttonSnapshot removeFromSuperview];
        }];
        
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:flag];
}

- (void)animatePathInContainer:(UIView *)container
                  launchedView:(UIView *)launchedView
                    startFrame:(CGRect)startFrame
                      endFrame:(CGRect)endFrame {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:startFrame];
    
    // define the masking layer to be able to show that circle animation
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = launchedView.frame;
    maskLayer.path = maskPath.CGPath;
    
    launchedView.layer.mask = maskLayer;
    
    // define the end frame
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:endFrame];
    
    // create the animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.delegate = self;
    pathAnimation.fromValue = (__bridge id _Nullable)(maskPath.CGPath);
    pathAnimation.toValue = bigCirclePath;
    pathAnimation.duration = [self transitionDuration:self.transitionContext];
    
    maskLayer.path = bigCirclePath.CGPath;
    [maskLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
}

@end
