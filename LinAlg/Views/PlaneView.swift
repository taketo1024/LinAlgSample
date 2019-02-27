//
//  PlaneView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class PlaneView: UIView {
    var unitLength: CGFloat = 50.0
    
    var width: CGFloat {
        return bounds.width
    }
    
    var height: CGFloat {
        return bounds.height
    }
    
    var planeOrigin: CGPoint {
        return CGPoint(width / 2, height / 2)
    }
    
    var vectorViews: [VectorView] {
        return subviews.compactMap{ $0 as? VectorView }
    }
    
    func convert(_ v: Vec2) -> CGPoint {
        let p = v.asCGPoint
        return CGPoint(
            width  / 2 + p.x * unitLength,
            height / 2 - p.y * unitLength
        )
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let center = bounds.center
        
        // fill background
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(self.bounds)
        
        // draw axises
        ctx.setLineWidth(1)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.move(to: CGPoint(0, center.y))
        ctx.addLine(to: CGPoint(width, center.y))
        ctx.strokePath()
        
        ctx.move(to: CGPoint(center.x, 0))
        ctx.addLine(to: CGPoint(center.x, height))
        ctx.strokePath()
        
        // vector arrows
        for v in vectorViews {
            if v.isHidden { continue }
            ctx.setLineWidth(v.lineWidth)
            ctx.setStrokeColor(v.color.cgColor)
            ctx.move(to: convert(.zero))
            ctx.addLine(to: convert(v.vector))
            ctx.strokePath()
        }
    }
    
    func add(_ v: Vec2, color: UIColor = .black) {
        let vecView = VectorView(frame: CGRect(0, 0, 34, 34))
        vecView.vector = v
        vecView.color = color
        vecView.backgroundColor = .clear
        addSubview(vecView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
        
        for vecView in vectorViews {
            vecView.frame.origin = convert(vecView.vector) - vecView.bounds.center
            vecView.setNeedsDisplay()
        }
    }
}
