import Foundation

public protocol AdditiveGroup: SetType {
    static var zero: Self { get }
    static func + (a: Self, b: Self) -> Self
    prefix static func - (x: Self) -> Self
    static func -(a: Self, b: Self) -> Self
    static func sum(_ elements: [Self]) -> Self
}

public extension AdditiveGroup {
    public static func -(a: Self, b: Self) -> Self {
        return (a + (-b))
    }
    
    public static func sum(_ elements: [Self]) -> Self {
        return elements.reduce(.zero){ (res, e) in res + e }
    }
}

public extension Sequence where Element: AdditiveGroup {
    public func sumAll() -> Element {
        return sum{ $0 }
    }
}

public extension Sequence {
    public func sum<G: AdditiveGroup>(mapping f: (Element) -> G) -> G {
        return G.sum( self.map(f) )
    }
}
