//
//  AFProgressiveBlurView.m
//  AnimationFun
//
//  Created by Wesley St. John on 11/12/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

#import "AFProgressiveBlurView.h"
#import "UIImage+ImageEffects.h"

#define USE_CIFILTER    NO

@interface AFProgressiveBlurView ()

@property (nonatomic, assign) CGFloat maxBlurRadius;
@property (nonatomic, assign) NSInteger numBlurStages;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) CIImage *ciImage;
@property (nonatomic, strong) CIFilter *gaussianBlurFilter;
@property (nonatomic, strong) CIContext *ciContext;

@end

@implementation AFProgressiveBlurView


#pragma mark - Public Methods

- (void)processBlurWithMaxRadius:(CGFloat)maxBlurRadius
                      inputImage:(UIImage *)inputImage
                         quality:(AFProgressiveBlurViewQuality)quality
                       completion:(AFProgressiveBlurViewProcessedBlock)completion {
    
    _maxBlurRadius = maxBlurRadius;
    _numBlurStages = quality;
    
    if (!inputImage) {
        return;
    }
    
    if (USE_CIFILTER) {
        [self setupBlurWithInputImage:inputImage];
    }
    
    self.images = [[NSMutableArray alloc] initWithObjects:inputImage, nil];
    
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSInteger blurIndex = 0; blurIndex < _numBlurStages; blurIndex++) {
            
            CGFloat blurAmount = maxBlurRadius * ( (blurIndex + 1) / (CGFloat)_numBlurStages);
            
            if (USE_CIFILTER) {
                [wself addBlurredImageWithRadius:blurAmount];
            } else {
                [wself.images addObject:[inputImage applyBlurWithRadius:blurAmount tintColor:nil saturationDeltaFactor:1 maskImage:nil]];
            }
        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });            
        }
        
    });
    
}

-(void)setBlurriness:(CGFloat)blurriness {
    
    _blurriness = MIN(1.0, MAX(0.0, blurriness));
    
    CGFloat blurFactor = blurriness * self.numBlurStages + 1;
    NSInteger blurIndex = (NSInteger)blurFactor;
    CGFloat blurRemainder = blurFactor - blurIndex;
    
    if (self.images.count > blurIndex - 1) {
        self.bottomImageView.image = self.images[blurIndex - 1];
        self.bottomImageView.alpha = 1.0;
    }
    
    if (self.images.count > blurIndex) {
        self.topImageView.image = self.images[blurIndex];
        self.topImageView.alpha = blurRemainder;
    }
}

#pragma mark - Private Methods

- (void)setupBlurWithInputImage:(UIImage *)inputImage {
    self.ciImage = [[CIImage alloc] initWithImage:inputImage];
    
    self.gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [self.gaussianBlurFilter setValue:self.ciImage forKey: @"inputImage"];
    
    self.ciContext = [[CIContext alloc] init];
}

- (void)addBlurredImageWithRadius:(CGFloat)radius {
    
    
    [self.gaussianBlurFilter setValue:@(radius) forKey:@"inputRadius"];
    
    CGImageRef cgImageRef = [self.ciContext createCGImage:self.gaussianBlurFilter.outputImage fromRect:self.ciImage.extent];
    
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImageRef];
    
    [self.images addObject:blurredImage];

}


@end
