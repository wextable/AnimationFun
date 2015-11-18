//
//  AFProgressiveBlurView.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/12/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AFProgressiveBlurViewQuality) {
    AFProgressiveBlurViewQualityLow = 1,
    AFProgressiveBlurViewQualityMedium = 3,
    AFProgressiveBlurViewQualityHigh = 6,
    AFProgressiveBlurViewQualityAwesome = 10
};

typedef void(^AFProgressiveBlurViewProcessedBlock)();

@interface AFProgressiveBlurView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *topImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bottomImageView;

@property (nonatomic, assign) CGFloat blurriness;

- (void)processBlurWithMaxRadius:(CGFloat)maxBlurRadius inputImage:(UIImage *)inputImage quality:(AFProgressiveBlurViewQuality)quality completion:(AFProgressiveBlurViewProcessedBlock)completion;

@end
