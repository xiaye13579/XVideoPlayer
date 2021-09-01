//
//  GradientView.swift
//  Radio Kine
//
//  Created by SuperBlack on 2020/9/13.
//  Copyright © 2020 CRI. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
//        if (isHorizontal) {
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint (x: 0, y: 1)
//        } else {
//            layer.startPoint = CGPoint(x: 0.5, y: 0)
//            layer.endPoint = CGPoint (x: 0.5, y: 1)
//        }
    }
}
