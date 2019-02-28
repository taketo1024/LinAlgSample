//
//  SquareMatrix.swift
//  SwiftyMath
//
//  Created by Taketo Sano on 2018/03/17.
//  Copyright © 2018年 Taketo Sano. All rights reserved.
//

import Foundation

public typealias SquareMatrix<n: _Int, R: Ring> = Matrix<n, n, R>

public typealias Matrix1<R: Ring> = SquareMatrix<_1, R>
public typealias Matrix2<R: Ring> = SquareMatrix<_2, R>
public typealias Matrix3<R: Ring> = SquareMatrix<_3, R>
public typealias Matrix4<R: Ring> = SquareMatrix<_4, R>

extension SquareMatrix: Monoid where n == m {}

extension SquareMatrix: Ring where n == m {
    public init(from n : 𝐙) {
        self.init { (i, j) in (i == j) ? R(from: n) : .zero }
    }
    
    public static var identity: Matrix<n, n, R> {
        return Matrix { $0 == $1 ? .identity : .zero }
    }
    
    public var isInvertible: Bool {
        return determinant.isInvertible
    }
    
    public var inverse: Matrix<n, n, R>? {
        fatalError("matrix-inverse not yet supported for a general ring.")
    }
    
    public func pow(_ n: 𝐙) -> SquareMatrix<n, R> {
        return (0 ..< n).reduce(.identity){ (res, _) in self * res }
    }
    
    public var trace: R {
        return (0 ..< rows).sum { i in self[i, i] }
    }
    
    public var determinant: R {
        fatalError()
    }
}

public extension SquareMatrix where n == m, n == _1 {
    public var asScalar: R {
        return self[0, 0]
    }
}

//public extension SquareMatrix where n == m, R: EuclideanRing {
//    public var determinant: R {
//        switch rows {
//        case 0: return .identity
//        case 1: return self[0, 0]
//        case 2: return self[0, 0] * self[1, 1] - self[1, 0] * self[0, 1]
//        default: return elimination().determinant
//        }
//    }
//
//    public var inverse: Matrix<n, n, R>? {
//        switch rows {
//        case 0: return .identity
//        case 1: return self[0, 0].inverse.flatMap{ Matrix($0) }
//        case 2:
//            let det = determinant
//            return (det.isInvertible)
//                ? det.inverse! * Matrix(self[1, 1], -self[0, 1], -self[1, 0], self[0, 0])
//                : nil
//        default: return elimination().inverse
//        }
//    }
//}
