//
//  Vector.swift
//  SwiftyMath
//
//  Created by Taketo Sano on 2018/03/17.
//  Copyright © 2018年 Taketo Sano. All rights reserved.
//

import Foundation

public typealias ColVector<n: _Int, R: Ring> = Matrix<n, _1, R>
public typealias RowVector<n: _Int, R: Ring> = Matrix<_1, n, R>

public typealias Vector2<R: Ring> = ColVector<_2, R>
public typealias Vector3<R: Ring> = ColVector<_3, R>
public typealias Vector4<R: Ring> = ColVector<_4, R>


public extension Matrix where m == _1 {
    public subscript(index: Int) -> R {
        get { return self[index, 0] }
        set { self[index, 0] = newValue }
    }
}

public extension Matrix where n == _1 {
    public subscript(index: Int) -> R {
        get { return self[0, index] }
        set { self[0, index] = newValue }
    }
}
