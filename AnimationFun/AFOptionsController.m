//
//  AFOptionsController.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/7/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFOptionsController.h"


@implementation AFAnimationOptions

@end

@implementation AFOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
    
    for (UIView *view in self.animatingViews) {
        view.transform = CGAffineTransformMakeScale(0, 0);
    }
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self animateIn];
//}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateIn];
}


-(void)setOptions:(AFAnimationOptions *)options {
    _options = options;
    
    [self updateUI];
}

- (void)updateUI {
    self.sliderDuration.value = self.options.duration;
    self.sliderDelay.value = self.options.delayFactor;
    [self.pickerOrderIn selectRow:self.options.orderIn inComponent:0 animated:NO];
    [self.pickerOrderOut selectRow:self.options.orderOut inComponent:0 animated:NO];
    [self.pickerAnimationType selectRow:self.options.animationType inComponent:0 animated:NO];
    [self.pickerOffscreenPosition selectRow:self.options.offscreenPosition inComponent:0 animated:NO];
}

- (void)animateIn {
    __weak typeof(self) wself = self;
    [AFUIViewCollectionAnimator animateViews:wself.animatingViews
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
}

- (void)animateOut {
    __weak typeof(self) wself = self;
    [AFUIViewCollectionAnimator animateViews:wself.animatingViews
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

- (IBAction)animateOutAndDismiss:(id)sender {
    [self animateOut];
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:self.options.duration * 0.667];
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)durationSliderValueChanged:(UISlider *)sender {
    self.options.duration = sender.value;
}

- (IBAction)delaySliderValueChanged:(UISlider *)sender {
    self.options.delayFactor = sender.value;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerOrderIn || pickerView == self.pickerOrderOut) {
        return AFCollectionAnimatorOrderCount;
    }
    
    if (pickerView == self.pickerAnimationType) {
        return AFAnimationTypeCount;
    }
    
    if (pickerView == self.pickerOffscreenPosition) {
        return AFAnimationOffscreenPositionCount;
    }
    
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 16;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString *title = @"";
    
    if (pickerView == self.pickerOrderIn || pickerView == self.pickerOrderOut) {
        switch (row) {
            case AFCollectionAnimatorOrderAscending:
                title = @"ascending";
                break;
            case AFCollectionAnimatorOrderDescending:
                title = @"descending";
                break;
            case AFCollectionAnimatorOrderRandom:
                title = @"random";
                break;
        }
    }
    
    if (pickerView == self.pickerAnimationType) {
        switch (row) {
            case AFAnimationTypePulse:
                title = @"pulse";
                break;
            case AFAnimationTypeSpin:
                title = @"spin";
                break;
            case AFAnimationTypeSlide:
                title = @"slide";
                break;
        }
    }
    
    if (pickerView == self.pickerOffscreenPosition) {
        switch (row) {
            case AFAnimationOffscreenPositionTop:
                title = @"top";
                break;
            case AFAnimationOffscreenPositionBottom:
                title = @"bottom";
                break;
            case AFAnimationOffscreenPositionLeft:
                title = @"left";
                break;
            case AFAnimationOffscreenPositionRight:
                title = @"right";
                break;
            case AFAnimationOffscreenPositionRandom:
                title = @"random";
                break;
        }
    }
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = title;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:16];
    
    return lbl;
}

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (pickerView == self.pickerOrderIn || pickerView == self.pickerOrderOut) {
//        switch (row) {
//            case AFCollectionAnimatorOrderAscending:
//                return @"ascending";
//                break;
//            case AFCollectionAnimatorOrderDescending:
//                return @"descending";
//                break;
//            case AFCollectionAnimatorOrderRandom:
//                return @"random";
//                break;
//        }
//    }
//    
//    if (pickerView == self.pickerAnimationType) {
//        switch (row) {
//            case AFAnimationTypePulse:
//                return @"pulse";
//                break;
//            case AFAnimationTypeSpin:
//                return @"spin";
//                break;
//            case AFAnimationTypeSlide:
//                return @"slide";
//                break;
//        }
//    }
//    
//    if (pickerView == self.pickerOffscreenPosition) {
//        switch (row) {
//            case AFAnimationOffscreenPositionTop:
//                return @"top";
//                break;
//            case AFAnimationOffscreenPositionBottom:
//                return @"bottom";
//                break;
//            case AFAnimationOffscreenPositionLeft:
//                return @"left";
//                break;
//            case AFAnimationOffscreenPositionRight:
//                return @"right";
//                break;
//            case AFAnimationOffscreenPositionRandom:
//                return @"random";
//                break;
//        }
//    }
//    
//    return @"";
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerOrderIn) {
        self.options.orderIn = row;
    }
    
    if (pickerView == self.pickerOrderOut) {
        self.options.orderOut = row;
    }
    
    if (pickerView == self.pickerAnimationType) {
        self.options.animationType = row;
    }
    
    if (pickerView == self.pickerOffscreenPosition) {
        self.options.offscreenPosition = row;
    }
}

@end
