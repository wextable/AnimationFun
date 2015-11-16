//
//  AFProgressiveBlurCrossfadeView.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/12/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFProgressiveBlurCrossfadeView.h"

@interface AFProgressiveBlurView ()
-(void)setBlurriness:(CGFloat)blurriness;
@end

@implementation AFProgressiveBlurCrossfadeView

-(void)setBlurriness:(CGFloat)blurriness {
    
    [super setBlurriness:blurriness];
    
    self.foregroundView.alpha = blurriness;
}

@end
