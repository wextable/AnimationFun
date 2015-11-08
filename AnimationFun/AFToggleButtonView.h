//
//  AFToggleButtonView.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFToggleButtonView;
typedef void(^AFToggleButtonViewTappedBlock)(AFToggleButtonView *sender);

IB_DESIGNABLE

@interface AFToggleButtonView : UIView

@property (strong, nonatomic) IBInspectable UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewSelected;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewUnselected;
@property (assign, nonatomic) BOOL selected;

@property (copy, nonatomic) AFToggleButtonViewTappedBlock tappedBlock;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
