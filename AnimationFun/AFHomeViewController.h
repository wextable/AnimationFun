//
//  AFHomeViewController.h
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFToggleButtonView;

@interface AFHomeViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *circleButtons;
@property (strong, nonatomic) IBOutlet AFToggleButtonView *btnStar;

@end

