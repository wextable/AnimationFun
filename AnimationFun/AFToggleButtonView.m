//
//  AFToggleButtonView.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFToggleButtonView.h"

#import "UIView+AFAnimation.h"

@interface AFToggleButtonView ()
@property (strong, nonatomic) UIImage *unselectedImage;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@end

@implementation AFToggleButtonView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}


-(void)awakeFromNib {
    self.imgViewSelected.image = self.image;
    self.imgViewUnselected.image = self.image;
    
    self.imgViewSelected.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.imgViewSelected.alpha = 0.0;
}

// TODO: figure out how this actually works!
-(void)prepareForInterfaceBuilder {
    self.imgViewSelected.image = self.image;
    self.imgViewUnselected.image = self.image;
    
    self.imgViewSelected.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.imgViewSelected.alpha = 0.0;
}

- (void)viewTapped {
    [self toggleSelected];
    
    if (self.tappedBlock) {
        self.tappedBlock(self);
    }
    
}


- (void)toggleSelected {
    self.selected = !self.selected;
}

-(void)setImage:(UIImage *)image {
    _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _unselectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imgViewSelected.image = image;
    self.imgViewUnselected.image = _unselectedImage;
}


-(void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (animated) {
        [self setSelectedWithAnimation:selected];
    } else {
        [self setSelectedWithNoAnimation:selected];
    }
}

- (void)setSelectedWithAnimation:(BOOL)selected {
    _selected = selected;
    
//    CGFloat animDuration = 0.75;
//    
//    CGFloat springDamping = 0.5;
//    CGFloat springVelocity = 1.0;
    
    if (selected) {
        
        [self.imgViewSelected pulseGrowView];
        
//        [self pulseGrowView:self.imgViewSelected];
        
//        [UIView animateWithDuration:animDuration
//                              delay:0
//             usingSpringWithDamping:springDamping
//              initialSpringVelocity:springVelocity
//                            options:0
//                         animations:^{
//                             
//                             self.imgViewSelected.transform = CGAffineTransformIdentity;
//                             self.imgViewSelected.alpha = 1.0;
//                             
//                         } completion:^(BOOL finished) {
//                             
//                         }];
        
    } else {
        
        [self.imgViewSelected pulseShrinkView];
        
//        [self pulseShrinkView:self.imgViewSelected];
        
//        [UIView animateWithDuration:0.2
//                         animations:^{
//                             self.imgViewSelected.transform = CGAffineTransformMakeScale(1.2, 1.2);
//                             
//                         } completion:^(BOOL finished) {
//                             
//                             
//                             [UIView animateWithDuration:animDuration
//                                                   delay:0
//                                  usingSpringWithDamping:springDamping
//                                   initialSpringVelocity:springVelocity
//                                                 options:0
//                                              animations:^{
//                                                  self.imgViewSelected.transform = CGAffineTransformMakeScale(0.1, 0.1);
//                                                  self.imgViewSelected.alpha = 0.0;
//                                                  
//                                              } completion:^(BOOL finished) {
//                                                  
//                                              }];
//                         }];
        
    }
}

- (void)setSelectedWithNoAnimation:(BOOL)selected {
    _selected = selected;
    
    if (selected) {
        self.imgViewSelected.transform = CGAffineTransformIdentity;
        self.imgViewSelected.alpha = 1.0;
    } else {
        self.imgViewSelected.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.imgViewSelected.alpha = 0.0;
    }
}


@end





