//
//  RoundImage.swift
//  MozBeauty
//
//  Created by Muhammad Fawwaz Mayda on 30/07/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

@IBDesignable class RoundImg: UIImageView {
    
    @IBInspectable var isRoundedCorner: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isRoundedCorner {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath(ovalIn:
                CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
            )).cgPath
            layer.mask = shapeLayer
        } else {
            layer.mask = nil
        }
    }
}

