//
//  VectorView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

protocol VectorViewDelegate: class {
    func vectorViewUpdated(_ v: VectorView)
    func vectorView(_ v: VectorView, dragged amount: CGPoint)
}

class VectorView: UIView {
    
    var vector: Vec2 = .zero {
        didSet {
            if vector != oldValue {
                setNeedsDisplay()
                delegate?.vectorViewUpdated(self)
            }
        }
    }
    
    var color: UIColor = .black
    var lineWidth: CGFloat = 2
    var headRadius: CGFloat { return lineWidth * 2.5 }
    var dragging: Bool = false
    
    weak var delegate: VectorViewDelegate?
    weak var related: VectorView?
    
    var headCenter: CGPoint {
        let r = headRadius * (dragging ? 1.5 : 1.0)
        let t = -vector.asCGPoint.arg
        return -r * CGPoint.unit(arg: t)
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        if isUserInteractionEnabled {
            let alpha: CGFloat = dragging ? 0.5 : 0.1
            ctx.setFillColor(color.withAlphaComponent(alpha).cgColor)
            ctx.fillEllipse(in: bounds)
        }
        
        ctx.setFillColor(color.cgColor)
        
        let r = headRadius * (dragging ? 1.5 : 1.0)
        if vector == .zero {
            let c = bounds.center
            ctx.fillEllipse(in: CGRect(c.x - r, c.y - r, 2 * r, 2 * r))
        } else {
            let π = CGFloat.pi
            let u = CGPoint.unit
            let t = -vector.asCGPoint.arg
            let c = bounds.center + headCenter
            
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
    
    private func dragged(_ state: UIGestureRecognizer.State, _ touches: Set<UITouch>) {
        dragging = (state == .began || state == .changed)
        if let t = touches.first {
            let a = t.location(in: self) - t.previousLocation(in: self)
            delegate?.vectorView(self, dragged: a)
        }
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dragged(.began, touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        dragged(.changed, touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        dragged(.cancelled, touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dragged(.ended, touches)
    }
}
