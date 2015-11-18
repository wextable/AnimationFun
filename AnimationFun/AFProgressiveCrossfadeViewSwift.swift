//
//  AFProgressiveCrossfadeViewSwift.swift
//  AnimationFun
//
//  Created by Wesley St. John on 11/17/15.
//  Copyright © 2015 Mobileforming. All rights reserved.
//

import UIKit

class AFProgressiveCrossfadeViewSwift: AFProgressiveBlurViewSwift {

    @IBOutlet var foregroundView: UIView?
    
    override var blurriness: Float {
        didSet {
            super.blurriness = blurriness
            
            foregroundView?.alpha = CGFloat(blurriness)
        }
    }


}
