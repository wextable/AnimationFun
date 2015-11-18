//
//  AFProgressiveBlurViewSwift.swift
//  AnimationFun
//
//  Created by Wesley St. John on 11/16/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

import UIKit


@objc enum AFProgressiveBlurViewQuality: Int {
    case Low = 1
    case Medium = 3
    case High = 6
    case Awesome = 10
}


@objc class AFProgressiveBlurViewSwift: UIView {
    
    @IBOutlet var topImageView: UIImageView?
    @IBOutlet var bottomImageView: UIImageView?
    
    var blurriness: Float {
        didSet {
            
            blurriness = min(1.0, max(0.0, blurriness))
            
            let blurFactor = blurriness * Float(numBlurStages) + 1
            let blurIndex = Int(blurFactor)
            let blurRemainder = blurFactor - Float(blurIndex)
            
            if (images.count > blurIndex - 1) {
                bottomImageView?.image = images[blurIndex - 1]
                bottomImageView?.alpha = 1.0
            }
            if (images.count > blurIndex) {
                topImageView?.image = images[blurIndex]
                topImageView?.alpha = CGFloat(blurRemainder)
            }
        }
    }

    // private
    private var maxBlurRadius: Float
    private var numBlurStages: Int
    private var images: [UIImage]
    
    required init?(coder aDecoder: NSCoder) {

        maxBlurRadius = 1
        numBlurStages = 0
        images = []
        blurriness = 0
        
        super.init(coder: aDecoder)
    }

    func processBlurWithMaxRadius(maxBlurRadius: Float,
        inputImage: UIImage?,
        quality: AFProgressiveBlurViewQuality,
        completion: (() -> Void)?
        ) {

            self.maxBlurRadius = maxBlurRadius
            self.numBlurStages = quality.rawValue
            
            guard let image = inputImage else {
                print("No input image!")
                return;
            }
            
            self.images = [image]
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                for blurIndex in 0...self.numBlurStages {
                    
                    let blurAmount = self.maxBlurRadius * ( Float(blurIndex + 1) / Float(self.numBlurStages));
                    
                    let blurredImage = image.applyBlurWithRadius(CGFloat(blurAmount), tintColor: nil, saturationDeltaFactor: 1, maskImage: nil)
                    self.images.append(blurredImage)
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    if let completionBlock = completion {
                        completionBlock()
                    }
                }
                
            }

    }

}
