//
//  RealFunctions.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/27.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import Foundation

public func exp(_ x: 𝐑) -> 𝐑 {
    return 𝐑(exp(x.value))
}

public func sin(_ x: 𝐑) -> 𝐑 {
    return 𝐑(sin(x.value))
}

public func cos(_ x: 𝐑) -> 𝐑 {
    return 𝐑(cos(x.value))
}

public func tan(_ x: 𝐑) -> 𝐑 {
    return 𝐑(tan(x.value))
}

public func asin(_ x: 𝐑) -> 𝐑 {
    return 𝐑(asin(x.value))
}

public func acos(_ x: 𝐑) -> 𝐑 {
    return 𝐑(acos(x.value))
}

public func atan(_ x: 𝐑) -> 𝐑 {
    return 𝐑(atan(x.value))
}
