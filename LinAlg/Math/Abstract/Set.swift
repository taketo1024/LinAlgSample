//
//  BasicTypes.swift
//  SwiftyMath
//
//  Created by Taketo Sano on 2017/06/05.
//  Copyright © 2017年 Taketo Sano. All rights reserved.
//

import Foundation

public protocol SetType: Hashable, CustomStringConvertible {
    static var symbol: String { get }
}

public extension SetType {
    public static var symbol: String {
        return String(describing: self)
    }
}
