//
//  AFCircleTransitionObject.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFCircleTransitionObject : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL reversing;
@property (strong, nonatomic) UIView *launchingView;

@end
