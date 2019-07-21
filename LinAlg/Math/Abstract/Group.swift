import Foundation

public protocol Group: Monoid {
    var inverse: Self { get }
}

extension Group {
    public func pow(_ n: 𝐙) -> Self {
        if n >= 0 {
            return (0 ..< n).reduce(.identity){ (res, _) in self * res }
        } else {
            return (0 ..< -n).reduce(.identity){ (res, _) in inverse * res }
        }
    }
}
