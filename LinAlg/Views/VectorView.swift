//
//  VectorView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class VectorView: UIView {
    
    var vector: Vec2 = .zero
    
    var color: UIColor = .black
    var lineWidth: CGFloat = 2
    
    var headRadius: CGFloat {
        return lineWidth * 2.5
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let c = bounds.center
        let r = headRadius
        
        ctx.setFillColor(color.cgColor)
        
        if vector == .zero {
            ctx.fillEllipse(in: CGRect(c.x - r, c.y - r, 2 * r, 2 * r))
        } else {
            let π = CGFloat.pi
            let t = -vector.asCGPoint.arg
            let u = CGPoint.unit
            
            ctx.beginPath()
            ctx.move(to: c + r * u(t))
            ctx.addLine(to: c + r * u(t + 2 * π / 3))
            ctx.addLine(to: c + r * u(t + 4 * π / 3))
            ctx.closePath()
            ctx.fillPath()
        }
    }
}
