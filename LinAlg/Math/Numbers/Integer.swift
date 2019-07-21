import Foundation

public typealias 𝐙 = Int

extension 𝐙: EuclideanRing {
    public init(from n: 𝐙) {
        self.init(n)
    }
    
    public static var zero: Int {
        return 0
    }
    
    public var inverse: 𝐙? {
        return (self.abs == 1) ? self : nil
    }
    
    public var normalizeUnit: 𝐙 {
        return (self > 0) ? 1 : -1
    }
    
    public var eucDegree: Int {
        return Swift.abs(self)
    }
    
    public var sign: 𝐙 {
        return (self >  0) ? 1 :
               (self == 0) ? 0 :
                            -1
    }
    
    public var abs: 𝐙 {
        return (self >= 0) ? self : -self
    }
    
    public var isEven: Bool {
        return (self % 2 == 0)
    }
    
    public var isOdd: Bool {
        return (self % 2 == 1)
    }
    
    public func pow(_ n: 𝐙) -> 𝐙 {
        switch  self {
        case 1:
            return 1
        case -1:
            return n.isEven ? 1 : -1
        default:
            assert(n >= 0)
            return (0 ..< n).reduce(1){ (res, _) in self * res }
        }
    }
    
    public func eucDiv(by b: 𝐙) -> (q: 𝐙, r: 𝐙) {
        let a = self
        let q = a / b
        return (q: q, r: a - q * b)
    }
    
    public static var symbol: String {
        return "𝐙"
    }
}
