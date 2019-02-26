//
//  VectorView.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class VectorView: UIView {
    
    var vector: CGPoint = .zero
    var color: UIColor = .red
    var width: CGFloat = 2
    
//    var plane: PlaneView {
//        return superview! as! PlaneView
//    }
//    
//    override func didMoveToSuperview() {
//        if superview is PlaneView {
//            fatalError()
//        }
//    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = false
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // draw axises
        ctx.setLineWidth(width)
        ctx.setStrokeColor(color.cgColor)
        ctx.move(to: .zero)
        ctx.addLine(to: vector)
        ctx.strokePath()
    }
}
