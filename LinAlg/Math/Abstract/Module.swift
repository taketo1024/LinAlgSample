import Foundation

public protocol Module: AdditiveGroup {
    associatedtype CoeffRing: Ring
    static func * (r: CoeffRing, m: Self) -> Self
    static func * (m: Self, r: CoeffRing) -> Self
}
