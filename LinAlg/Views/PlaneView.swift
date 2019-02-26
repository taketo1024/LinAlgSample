//
//  PlaneView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
}

class PlaneView: UIView {
    var pointSize: CGFloat = 8.0
    var unit: CGFloat = 50.0
    var scale: CGFloat = 1.0
    
    var width: CGFloat {
        return bounds.width
    }
    
    var height: CGFloat {
        return bounds.height
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // fill background
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(self.bounds)
        
        // draw axises
        ctx.setLineWidth(1)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.move(to: CGPoint(0, height / 2))
        ctx.addLine(to: CGPoint(width, height / 2))
        ctx.strokePath()
        
        ctx.move(to: CGPoint(width / 2, 0))
        ctx.addLine(to: CGPoint(width / 2, height))
        ctx.strokePath()
    }
}
