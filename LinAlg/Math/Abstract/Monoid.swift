import Foundation

public protocol Monoid: SetType {
    static func * (a: Self, b: Self) -> Self
    static var identity: Self { get }
    func pow(_ n: 𝐙) -> Self
}

public extension Monoid {
    public func pow(_ n: 𝐙) -> Self {
        assert(n >= 0)
        return (0 ..< n).reduce(.identity){ (res, _) in self * res }
    }
}

public extension Sequence where Element: Monoid {
    public func multiplyAll() -> Element {
        return multiply{ $0 }
    }
}

public extension Sequence {
    public func multiply<G: Monoid>(mapping f: (Element) -> G) -> G {
        return self.reduce(.identity){ $0 * f($1) }
    }
}
