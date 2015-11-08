//
//  AFOptionsController.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/7/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFUIViewCollectionAnimator.h"
#import "UIView+AFAnimation.h"

@interface AFAnimationOptions : NSObject

@property (assign, nonatomic) CGFloat duration;
@property (assign, nonatomic) CGFloat delayFactor;
@property (assign, nonatomic) AFCollectionAnimatorOrder orderIn;
@property (assign, nonatomic) AFCollectionAnimatorOrder orderOut;
@property (assign, nonatomic) AFAnimationType animationType;
@property (assign, nonatomic) AFAnimationOffscreenPosition offscreenPosition;

@end


@interface AFOptionsController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) AFAnimationOptions *options;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *animatingViews;

@property (nonatomic, strong) IBOutlet UISlider *sliderDuration;
@property (nonatomic, strong) IBOutlet UISlider *sliderDelay;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerOrderIn;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerOrderOut;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerAnimationType;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerOffscreenPosition;

@end
