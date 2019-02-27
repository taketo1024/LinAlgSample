//
//  CGExtensions.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/27.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
    
    static func +(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(p1.x + p2.x, p1.y + p2.y)
    }
    
    static prefix func -(p: CGPoint) -> CGPoint {
        return CGPoint(-p.x, -p.y)
    }
    
    static func -(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return p1 + (-p2)
    }
    
    static func *(a: CGFloat, p: CGPoint) -> CGPoint {
        return CGPoint(a * p.x, a * p.y)
    }
    
    static func unit(arg t: CGFloat) -> CGPoint {
        return CGPoint(cos(t), sin(t))
    }
    
    public var abs: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    public var arg: CGFloat {
        let r = abs
        if(r == 0) {
            return 0
        }
        
        let π = CGFloat.pi
        let t = acos(x / r)
        return (y >= 0) ? t : 2 * π - t
    }
}

extension CGSize {
    init(_ w: CGFloat, _ h: CGFloat) {
        self.init(width: w, height: h)
    }
}

extension CGRect {
    init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.init(origin: CGPoint(x, y), size: CGSize(w, h))
    }
    
    var center: CGPoint {
        return CGPoint(minX + width / 2, minY + height / 2)
    }
}

extension Double {
    var asCGFloat: CGFloat {
        return CGFloat(self)
    }
}

extension CGContext {
    func addCircle(center: CGPoint, radius: CGFloat) {
        addArc(center: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    }
    
    func addLine(within frame: CGRect, passing p: CGPoint, arg: CGFloat) {
        if abs(tan(arg)) < tan(frame.size.height / frame.size.width) {
            func point(_ x: CGFloat) -> CGPoint {
                return CGPoint(x, tan(arg) * (x - p.x) + p.y)
            }
            move(to: point(frame.minX))
            addLine(to: point(frame.maxX))
        } else {
            let π = CGFloat.pi
            func point(_ y: CGFloat) -> CGPoint {
                return CGPoint(tan(π/2 - arg) * (y - p.y) + p.x, y)
            }
            move(to: point(frame.minY))
            addLine(to: point(frame.maxY))
        }
    }
    

}
