//
//  AFHomeViewController.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFHomeViewController.h"
#import "AFCircleTransitionObject.h"
#import "AFToggleButtonView.h"
#import "AFBlurController.h"
#import "AFUIViewCollectionAnimator.h"
#import "UIView+AFAnimation.h"
#import "AFOptionsController.h"

@interface AFHomeViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) AFCircleTransitionObject *transitionObject;
@property (strong, nonatomic) UIButton *btnLaunchingTransition;
@property (strong, nonatomic) AFAnimationOptions *options;

@end


@implementation AFHomeViewController


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.transitionObject = [[AFCircleTransitionObject alloc] init];

        
        self.options = [[AFAnimationOptions alloc] init];
        self.options.duration = 0.75;
        self.options.delayFactor = 0.25;
        self.options.orderIn = AFCollectionAnimatorOrderAscending;
        self.options.orderOut = AFCollectionAnimatorOrderDescending;
        self.options.animationType = AFAnimationTypePulse;
        self.options.offscreenPosition = AFAnimationOffscreenPositionRight;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Animating Collections";
    
    self.navigationController.delegate = self;
    
    [self.btnStar setSelected:YES animated:NO];
    
    
    __weak typeof(self) wself = self;
    self.btnStar.tappedBlock = ^(AFToggleButtonView *sender) {
        
        if (sender.selected) {

            [AFUIViewCollectionAnimator animateViews:wself.circleButtons
                                       totalDuration:wself.options.duration
                                      maxDelayFactor:wself.options.delayFactor
                                               order:wself.options.orderIn
                                      animationBlock:^(UIView *view, CGFloat delay, CGFloat duration) {
                                          
                                          switch (wself.options.animationType) {
                                              case AFAnimationTypePulse:
                                                  [view pulseGrowViewWithDelay:delay duration:duration];
                                                  break;
                                              case AFAnimationTypeSpin:
                                                  [view spinUpViewWithDelay:delay duration:duration];
                                                  break;
                                              case AFAnimationTypeSlide:
                                                  [view slideViewInFromOffscreenPosition:wself.options.offscreenPosition delay:delay duration:duration];
                                                  break;
                                              default:
                                                  break;
                                          }
                                          
                                      }];
            
            
        } else {
            
            [AFUIViewCollectionAnimator animateViews:wself.circleButtons
                                       totalDuration:wself.options.duration * 0.667
                                      maxDelayFactor:wself.options.delayFactor //* 2.0
                                               order:wself.options.orderOut
                                      animationBlock:^(UIView *view, CGFloat delay, CGFloat duration) {
                                          
                                          switch (wself.options.animationType) {
                                              case AFAnimationTypePulse:
                                                  [view pulseShrinkViewWithDelay:delay duration:duration];
                                                  break;
                                              case AFAnimationTypeSpin:
                                                  [view spinDownViewWithDelay:delay duration:duration];
                                                  break;
                                              case AFAnimationTypeSlide:
                                                  [view slideViewOutToOffscreenPosition:wself.options.offscreenPosition delay:delay duration:duration];
                                                  break;
                                              default:
                                                  break;
                                          }
                                          
                                      }];
            
        }
        
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    self.navigationController.delegate = nil;
}


- (IBAction)circleTapped:(UIButton *)sender {

    self.btnLaunchingTransition = sender;
    
    [self performSegueWithIdentifier:@"segueCircle" sender:sender];
}


#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"segueOptions"]) {
        AFOptionsController *optionsController = segue.destinationViewController;
        optionsController.options = self.options;
    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}


#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    
    if ([NSStringFromClass(fromVC.class) isEqualToString:@"AFHomeViewController"] && [NSStringFromClass(toVC.class) isEqualToString:@"AFBlurController"]) {
        self.transitionObject.reversing = NO;
        self.transitionObject.launchingView = self.btnLaunchingTransition;
        return self.transitionObject;
    }
        
    if ([NSStringFromClass(fromVC.class) isEqualToString:@"AFBlurController"] && [NSStringFromClass(toVC.class) isEqualToString:@"AFHomeViewController"]) {
        self.transitionObject.reversing = YES;
        return self.transitionObject;
    }
    
    return nil;
}


@end
