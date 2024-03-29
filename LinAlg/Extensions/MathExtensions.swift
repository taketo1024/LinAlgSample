//
//  MathExtensions.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/27.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import Foundation
import CoreGraphics

typealias Vec2 = ColVector<_2, 𝐑>
typealias Mat2 = Matrix2<𝐑>

extension 𝐑 {
    func roundedString() -> String {
        let r = abs
        if Swift.abs(r - r.rounded()) < 0.01 {
            return String(Int(rounded()))
        }
        if r < 10 {
            return String(format: "%.2f", self)
        } else {
            return String(format: "%.1f", self)
        }
    }
}

extension Matrix where R == 𝐑, n == _2, m == _1 {
    init(_ p: CGPoint) {
        self.init(𝐑(p.x.asDouble), 𝐑(p.y.asDouble))
    }
    
    var x: R {
        return self[0]
    }
    
    var y: R {
        return self[1]
    }
    
    var asCGPoint: CGPoint {
        return CGPoint(x.asCGFloat, y.asCGFloat)
    }
}

extension Matrix where R == 𝐑, n == _2, m == _2 {
    static func rotation(_ θ: R) -> Matrix<n, m, R> {
        let (c, s) = (cos(θ), sin(θ))
        return Matrix(c, -s, s, c)
    }
}
