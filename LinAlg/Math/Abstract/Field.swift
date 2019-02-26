import Foundation

public protocol Field: EuclideanRing {}

public extension Field {
    public var normalizeUnit: Self {
        return self.inverse!
    }
    
    public var eucDegree: Int {
        return self == .zero ? 0 : 1
    }
    
    public func eucDiv(by b: Self) -> (q: Self, r: Self) {
        return (self / b, .zero)
    }
    
    public static func / (a: Self, b: Self) -> Self {
        return a * b.inverse!
    }
}
