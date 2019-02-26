import Foundation

public protocol Ring: AdditiveGroup, Monoid {
    init(from: 𝐙)
    var inverse: Self? { get }
    var isInvertible: Bool { get }
    var normalizeUnit: Self { get }
}

public extension Ring {
    public var isInvertible: Bool {
        return (inverse != nil)
    }
    
    public var normalizeUnit: Self {
        return .identity
    }
    
    public func pow(_ n: Int) -> Self {
        if n >= 0 {
            return (0 ..< n).reduce(.identity){ (res, _) in self * res }
        } else {
            return (0 ..< -n).reduce(.identity){ (res, _) in inverse! * res }
        }
    }
    
    public static var zero: Self {
        return Self(from: 0)
    }
    
    public static var identity: Self {
        return Self(from: 1)
    }
}
