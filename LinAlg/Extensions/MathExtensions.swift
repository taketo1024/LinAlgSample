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

extension Matrix where R == 𝐑, m == _1, n == _2 {
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
        return CGPoint(x.asDouble.asCGFloat, y.asDouble.asCGFloat)
    }
}
