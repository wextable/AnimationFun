//
//  AFIntroController.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/16/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFIntroController.h"
#import "UIView+AFAnimation.h"

@interface AFIntroController ()

@property (assign, nonatomic) BOOL isPulseViewNormalState;
@property (assign, nonatomic) BOOL isSpinViewNormalState;
@property (assign, nonatomic) BOOL isSlideViewNormalState;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewPulse;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewSpin;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewSlide;

@end

@implementation AFIntroController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Animation Primitives";
    
    self.isPulseViewNormalState = YES;
    self.isSpinViewNormalState = YES;
    self.isSlideViewNormalState = YES;
}



- (IBAction)pulse:(id)sender {
    
    if (self.isPulseViewNormalState) {
        [self.imgViewPulse pulseShrinkView];
    } else {
        [self.imgViewPulse pulseGrowView];
    }
    
    self.isPulseViewNormalState = !self.isPulseViewNormalState;
}

- (IBAction)spin:(id)sender {
    
    if (self.isSpinViewNormalState) {
        [self.imgViewSpin spinDownView];
    } else {
        [self.imgViewSpin spinUpView];
    }
    
    self.isSpinViewNormalState = !self.isSpinViewNormalState;
}

- (IBAction)slide:(id)sender {
    
    if (self.isSlideViewNormalState) {
        [self.imgViewSlide slideViewOutToOffscreenPosition:AFAnimationOffscreenPositionRight];
    } else {
        [self.imgViewSlide slideViewInFromOffscreenPosition:AFAnimationOffscreenPositionBottom];
    }
    
    self.isSlideViewNormalState = !self.isSlideViewNormalState;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
