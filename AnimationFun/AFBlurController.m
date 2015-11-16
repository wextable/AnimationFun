//
//  AFBlurController.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/5/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFBlurController.h"
#import "AFProgressiveBlurView.h"

@interface AFBlurController ()

@property (nonatomic, strong) IBOutlet AFProgressiveBlurView *blurView;
@property (nonatomic, strong) IBOutlet UISlider *blurSlider;
@property (nonatomic, strong) IBOutlet UIButton *btnStar;

@end

@implementation AFBlurController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Progressive Blur";
    
    UIImage *imgStar = [self.btnStar imageForState:UIControlStateNormal];
    [self.btnStar setImage:[imgStar imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    UIImage *imageToBlur = [UIImage imageNamed:@"heroes"];
    __weak typeof(self) wself = self;
    [self.blurView processBlurWithMaxRadius:15.0 inputImage:imageToBlur quality:AFProgressiveBlurViewQualityLow competion:^{
        wself.blurSlider.value = 0.0;
        wself.blurView.blurriness = 0.0;
    }];
}


- (IBAction)blurSliderValueChanged:(UISlider *)sender {
    
    self.blurView.blurriness = sender.value;
}

- (IBAction)qualityButtonTapped:(UIBarButtonItem *)sender {
    
    UIImage *imageToBlur = [UIImage imageNamed:@"heroes"];
    __weak typeof(self) wself = self;
    [self.blurView processBlurWithMaxRadius:15.0 inputImage:imageToBlur quality:sender.tag competion:^{
        wself.blurSlider.value = 0.0;
        wself.blurView.blurriness = 0.0;
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
