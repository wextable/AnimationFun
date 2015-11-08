//
//  UIView+AFAnimation.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "UIView+AFAnimation.h"


@implementation UIView (AFAnimation)


#pragma mark - Spinning up and down

- (void)spinUpView {
    [self spinUpViewWithDelay:0.0 duration:0.75];
}

- (void)spinUpViewWithDelay:(CGFloat)delay duration:(CGFloat)duration {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 0.01, 0.01);
    transform = CGAffineTransformRotate(transform, -M_PI_2);
    self.transform = transform;
    
    CGFloat springDamping = 0.55;
    CGFloat springVelocity = 1.0;
    
    
    transform = self.transform;
    transform = CGAffineTransformScale(transform, 100.0, 100.0);
    transform = CGAffineTransformRotate(transform, M_PI_2);
    
    
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:springDamping
          initialSpringVelocity:springVelocity
                        options:0
                     animations:^{
                         
                         self.transform = transform;
                         
                     } completion:^(BOOL finished) {

                     }];
    
}

- (void)spinDownView {
    [self spinDownViewWithDelay:0.0 duration:0.5];
}

- (void)spinDownViewWithDelay:(CGFloat)delay duration:(CGFloat)duration {

    CGFloat duration1 = duration * 0.2;
    CGFloat duration2 = duration - duration1;
    
    CGAffineTransform intermediateTransform = CGAffineTransformIdentity;
    intermediateTransform = CGAffineTransformScale(intermediateTransform, 1.1, 1.1);
    intermediateTransform = CGAffineTransformRotate(intermediateTransform, M_PI_2 * 0.1);
    
    [UIView animateWithDuration:duration1
                          delay:delay
                        options:0
                     animations:^{
                
        self.transform = intermediateTransform;
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration2
                         animations:^{
            
            CGAffineTransform transform = intermediateTransform;
            transform = CGAffineTransformScale(transform, 0.01, 0.01);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            self.transform = transform;
            
        } completion:^(BOOL finished) {
            self.transform = CGAffineTransformMakeScale(0, 0);
        }];
        
    }];
    
}


#pragma mark - Pulsing big and small 

- (void)pulseGrowView {
    [self pulseGrowViewWithDelay:0.0 duration:0.75];
}

- (void)pulseGrowViewWithDelay:(CGFloat)delay duration:(CGFloat)duration {
    
    CGFloat springDamping = 0.5;
    CGFloat springVelocity = 1.0;
    
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:springDamping
          initialSpringVelocity:springVelocity
                        options:0
                     animations:^{
                         
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {

                     }];
}

- (void)pulseShrinkView {
    [self pulseShrinkViewWithDelay:0.0 duration:0.5];
}

- (void)pulseShrinkViewWithDelay:(CGFloat)delay duration:(CGFloat)duration {
    
    CGFloat duration1 = duration * 0.3;
    CGFloat duration2 = duration - duration1;
    
    [UIView animateWithDuration:duration1
                          delay:delay
                        options:0
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.2, 1.2);
                         
                     } completion:^(BOOL finished) {
                         
                         
                         [UIView animateWithDuration:duration2
                                          animations:^{
                                              self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                                              self.alpha = 0.2;
                                              
                                          } completion:^(BOOL finished) {
                                              self.transform = CGAffineTransformMakeScale(0, 0);
                                          }];
                     }];
}


#pragma mark - Sliding in and out of screen

- (CGPoint)offsetForOffscreenPosition:(AFAnimationOffscreenPosition)position {
 
    CGFloat dx;
    CGFloat dy;
    
    if (position == AFAnimationOffscreenPositionRandom) {
        NSInteger randomSide = arc4random_uniform((u_int32_t)4);
        switch (randomSide) {
            case AFAnimationOffscreenPositionTop:
            case AFAnimationOffscreenPositionBottom:
                dy = [self yPositionOffsetForOffscreenPosition:randomSide];
                dx = arc4random_uniform((u_int32_t)self.superview.frame.size.width) - self.superview.frame.size.width/2.0;
                break;
            case AFAnimationOffscreenPositionLeft:
            case AFAnimationOffscreenPositionRight:
                dx = [self xPositionOffsetForOffscreenPosition:randomSide];
                dy = arc4random_uniform((u_int32_t)self.superview.frame.size.height) - self.superview.frame.size.height/2.0;
                break;
            default:
                break;
        }
        
        
    } else {
        dx = [self xPositionOffsetForOffscreenPosition:position];
        dy = [self yPositionOffsetForOffscreenPosition:position];
    }
    
    return CGPointMake(dx, dy);
}


- (CGFloat)xPositionOffsetForOffscreenPosition:(AFAnimationOffscreenPosition)position {
    CGFloat x = self.center.x;
    CGFloat halfWidth = self.frame.size.width / 2.0;
    CGFloat superViewWidth = self.superview.frame.size.width;
    
    CGFloat dx = 0;
    
    switch (position) {
        case AFAnimationOffscreenPositionLeft:
            dx = -x - halfWidth;
            break;
        case AFAnimationOffscreenPositionRight:
            dx = superViewWidth - x + halfWidth;
        default:
            break;
    }
    
    return dx;
}

- (CGFloat)yPositionOffsetForOffscreenPosition:(AFAnimationOffscreenPosition)position {
    CGFloat y = self.center.y;
    CGFloat halfHeight = self.frame.size.height / 2.0;
    CGFloat superViewHeight = self.superview.frame.size.height;
    
    CGFloat dy = 0;
    
    switch (position) {
        case AFAnimationOffscreenPositionTop:
            dy = -y -halfHeight;
            break;
        case AFAnimationOffscreenPositionBottom:
            dy = superViewHeight - y + halfHeight;
            break;
        default:
            break;
    }
    
    return dy;
}

- (void)slideViewInFromOffscreenPosition:(AFAnimationOffscreenPosition)position {
    [self slideViewInFromOffscreenPosition:position delay:0.0 duration:0.5];
}

- (void)slideViewInFromOffscreenPosition:(AFAnimationOffscreenPosition)position delay:(CGFloat)delay duration:(CGFloat)duration {
    
    CGPoint offset = [self offsetForOffscreenPosition:position];
    CGFloat dx = offset.x;
    CGFloat dy = offset.y;
    
    self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, dx, dy);
    
    CGFloat springDamping = 0.65;
    CGFloat springVelocity = 0.0;
    
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:springDamping
          initialSpringVelocity:springVelocity
                        options:0
                     animations:^{
                         
                         self.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)slideViewOutToOffscreenPosition:(AFAnimationOffscreenPosition)position {
    [self slideViewOutToOffscreenPosition:position delay:0.0 duration:0.4];
}

- (void)slideViewOutToOffscreenPosition:(AFAnimationOffscreenPosition)position delay:(CGFloat)delay duration:(CGFloat)duration {

    CGPoint offset = [self offsetForOffscreenPosition:position];
    CGFloat dx = offset.x;
    CGFloat dy = offset.y;
    
    CGFloat initialDx = dx * -0.1;
    CGFloat initialDy = dy * -0.1;
    
    dx -= initialDx;
    dy -= initialDy;
    
    CGFloat duration1 = duration * 0.25;
    CGFloat duration2 = duration - duration1;
    
    CGAffineTransform intermediateTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, initialDx, initialDy);
    
    [UIView animateWithDuration:duration1
                          delay:delay
                        options:0
                     animations:^{
                         self.transform = intermediateTransform;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:duration2
                                          animations:^{
                                              self.transform = CGAffineTransformTranslate(intermediateTransform, dx, dy);
                                              
                                          } completion:^(BOOL finished) {

                                          }];
                     }];
}

@end



