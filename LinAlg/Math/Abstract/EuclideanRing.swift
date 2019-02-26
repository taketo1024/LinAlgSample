import Foundation

public protocol EuclideanRing: Ring {
    var  eucDegree: Int { get }
    func eucDiv(by b: Self) -> (q: Self, r: Self) // override point
    
    static func /% (a: Self, b: Self) -> (q: Self, r: Self)
    static func / (a: Self, b: Self) -> Self
    static func % (a: Self, b: Self) -> Self
}

public extension EuclideanRing {
    public static func /% (_ a: Self, b: Self) -> (q: Self, r: Self) {
        return a.eucDiv(by: b)
    }
    
    public static func / (_ a: Self, b: Self) -> Self {
        return a.eucDiv(by: b).q
    }
    
    public static func % (_ a: Self, b: Self) -> Self {
        return a.eucDiv(by: b).r
    }
}

public func gcd<R: EuclideanRing>(_ a: R, _ b: R) -> R {
    switch b {
    case .zero:
        return a
    default:
        return gcd(b, a % b)
    }
}

public func lcm<R: EuclideanRing>(_ a: R, _ b: R) -> R {
    return (a * b) / gcd(a, b)
}
