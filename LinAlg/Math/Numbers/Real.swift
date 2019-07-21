import Foundation

public typealias 𝐑 = Double

extension 𝐑: Field {
    public init(from x: 𝐙) {
        self.init(x)
    }
    
    public init(_ r: 𝐐) {
        self.init(Double(r.p) / Double(r.q))
    }
    
    public static var zero: Double {
        return 0
    }
    
    public var sign: 𝐙 {
        return (self >  0) ? 1 :
               (self == 0) ? 0 :
                             -1
    }
    
    public var abs: 𝐑 {
        return Swift.abs(self)
    }
    
    public var inverse: 𝐑? {
        // 1/(x + e) ~ 1/x - (1/x^2)e + ...
        return (self != 0) ? 1/self : nil
    }
    
    public var sqrt: 𝐑 {
        return self.squareRoot()
    }
    
    public static prefix func √(x: 𝐑) -> 𝐑 {
        return x.sqrt
    }
    
    public var asComplex: 𝐂 {
        return 𝐂(self, .zero)
    }
    
    public static var symbol: String {
        return "𝐑"
    }
}

public let π = 𝐑(Double.pi)
