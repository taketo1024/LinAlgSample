//
//  Vector.swift
//  SwiftyMath
//
//  Created by Taketo Sano on 2018/03/17.
//  Copyright © 2018年 Taketo Sano. All rights reserved.
//

import Foundation

public typealias ColVector<n: _Int, R: Ring> = Matrix<n, _1, R>
public typealias RowVector<m: _Int, R: Ring> = Matrix<_1, m, R>

// ColVector
extension Matrix where m == _1 {
    public subscript(index: Int) -> R {
        get { return self[index, 0] }
        set { self[index, 0] = newValue }
    }
}

// RowVector
extension Matrix where n == _1 {
    public subscript(index: Int) -> R {
        get { return self[0, index] }
        set { self[0, index] = newValue }
    }
}
