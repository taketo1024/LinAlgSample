//
//  VectorView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class VectorView: UIView {
    
    var vector: Vec2 = .zero {
        didSet {
            update()
            setNeedsDisplay()
        }
    }
    
    var color: UIColor = .black
    var lineWidth: CGFloat = 2
    var headRadius: CGFloat {
        return lineWidth * 2.5
    }
    
    weak var related: VectorView?
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        if isUserInteractionEnabled {
            ctx.setFillColor(color.withAlphaComponent(0.2).cgColor)
            ctx.fillEllipse(in: bounds)
        }
        
        ctx.setFillColor(color.cgColor)
        
        let r = headRadius
        if vector == .zero {
            let c = bounds.center
            ctx.fillEllipse(in: CGRect(c.x - r, c.y - r, 2 * r, 2 * r))
        } else {
            let π = CGFloat.pi
            let u = CGPoint.unit
            let t = -vector.asCGPoint.arg
            let c = bounds.center - r * u(t)
            
            ctx.beginPath()
            ctx.move(to: c + r * u(t))
            ctx.addLine(to: c + r * u(t + 2 * π / 3))
            ctx.addLine(to: c + r * u(t + 4 * π / 3))
            ctx.closePath()
            ctx.fillPath()
        }
    }
    
    func update() {
        if let planeView = superview as? PlaneView {
            center = planeView.convertVector(vector)
            planeView.setNeedsDisplay()
        }
    }
}
