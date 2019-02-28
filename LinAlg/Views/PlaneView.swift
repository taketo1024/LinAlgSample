//
//  PlaneView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

protocol PlaneViewDelegate: class {
    func planeView(_ plane: PlaneView, vectorUpdated v: VectorView)
}

class PlaneView: UIView, VectorViewDelegate {
    let vectorViewSize: CGFloat = 40.0
    var vectorViews: [VectorView] = []
    
    var unitLength: CGFloat = 30.0 {
        didSet {
            setNeedsDisplay()
            vectorViews.forEach{ v in v.update() }
        }
    }

    var delegate: PlaneViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
    }
    
    var gridVectorViews: (VectorView, VectorView)?
    
    var width: CGFloat {
        return bounds.width
    }
    
    var height: CGFloat {
        return bounds.height
    }
    
    var planeOrigin: CGPoint {
        return CGPoint(width / 2, height / 2)
    }
    
    func convertVector(_ v: Vec2) -> CGPoint {
        return bounds.center + unitLength * v.asCGPoint.flipY
    }
    
    func convertPoint(_ p: CGPoint) -> Vec2 {
        return Vec2( ((p - bounds.center) / unitLength).flipY )
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let center = bounds.center
        
        // TODO: extract GridView and AxesView
        
        // drawGrid
        if let (v0, v1) = gridVectorViews {
            [(v0, v1), (v1, v0)].forEach { (v0, v1) in
                let a = v0.vector
                let b = v1.vector
                for i in (-20 ..< 20) { // TODO calculate line nums
                    ctx.setStrokeColor(v0.color.cgColor)
                    ctx.addLine(within: bounds, passing: convertVector(a + 𝐑(i) * b), arg: -a.asCGPoint.arg)
                    ctx.strokePath()
                }
            }
        }
        
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
            ctx.setLineWidth(v.lineWidth * (v.dragging ? 1.5 : 1.0))
            ctx.setStrokeColor(v.color.cgColor)
            ctx.move(to: convertVector(.zero))
            ctx.addLine(to: v.center + v.headCenter)
            ctx.strokePath()
        }
    }
    
    @discardableResult
    func add(_ v: Vec2, color: UIColor = .black, userInteractionEnabled: Bool = false) -> VectorView {
        let vecView = VectorView(frame: CGRect(0, 0, vectorViewSize, vectorViewSize))
        vecView.tag = vectorViews.count
        vecView.backgroundColor = .clear
        vecView.isUserInteractionEnabled = userInteractionEnabled
        
        vecView.delegate = self
        vecView.vector = v
        vecView.color = color

        vectorViews.append(vecView)
        addSubview(vecView)
        
        return vecView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
        
        for v in vectorViews {
            v.center = convertVector(v.vector)
            v.setNeedsDisplay()
        }
    }
    
    func vectorViewUpdated(_ v: VectorView) {
        v.center = convertVector(v.vector)
        setNeedsDisplay()
        delegate?.planeView(self, vectorUpdated: v)
    }
    
    func vectorView(_ v: VectorView, dragged amount: CGPoint) {
        v.vector = convertPoint(v.center + amount) // vectorViewUpdated will be called
    }
}
