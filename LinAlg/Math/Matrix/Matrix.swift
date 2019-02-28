import Foundation

public struct Matrix<n: _Int, m: _Int, R: Ring>: Module {
    public typealias CoeffRing = R
    
    public var grid: [R]
    
    public var rows: Int { return n.intValue }
    public var cols: Int { return m.intValue }

    // 1. Initialize by Grid.
    public init(_ grid: [R]) {
        self.grid = grid
    }
    
    public init(_ grid: R...) {
        self.init(grid)
    }
    
    // 2. Initialize by Generator.
    public init(generator g: (Int, Int) -> R) {
        let (rows, cols) = (n.intValue, m.intValue)
        let grid = (0 ..< rows).flatMap { i in
            (0 ..< cols).map { j in g(i, j) }
        }
        self.init(grid)
    }
    
    public subscript(i: Int, j: Int) -> R {
        get { return grid[i * cols + j] }
        set { grid[i * cols + j] = newValue }
    }
    
    public static func fill(_ a: R) -> Matrix<n, m, R> {
        return Matrix { (_, _) in a }
    }
    
    public static func diagonal(_ d: [R]) -> Matrix<n, m, R> {
        return Matrix { (i, j) in (i == j && i < d.count) ? d[i] : .zero }
    }
    
    public static func diagonal(_ d: R...) -> Matrix<n, m, R> {
        return Matrix.diagonal(d)
    }
    
    public static func scalar(_ a: R) -> Matrix<n, m, R> {
        return Matrix { (i, j) in (i == j) ? a : .zero }
    }
    
    public static var zero: Matrix<n, m, R> {
        return Matrix<n, m, R> { _,_ in .zero }
    }
    
    public static func unit(_ i0: Int, _ j0: Int) -> Matrix<n, m, R> {
        return Matrix { (i, j) in (i, j) == (i0, j0) ? .identity : .zero }
    }
    
    public static func ==(a: Matrix<n, m, R>, b: Matrix<n, m, R>) -> Bool {
        return a.grid == b.grid
    }
    
    public static func +(a: Matrix<n, m, R>, b: Matrix<n, m, R>) -> Matrix<n, m, R> {
        return Matrix{ (i, j) in a[i, j] + b[i, j] }
    }
    
    public prefix static func -(a: Matrix<n, m, R>) -> Matrix<n, m, R> {
        return Matrix{ (i, j) in -a[i, j] }
    }
    
    public static func *(r: R, a: Matrix<n, m, R>) -> Matrix<n, m, R> {
        return Matrix{ (i, j) in r * a[i, j] }
    }
    
    public static func *(a: Matrix<n, m, R>, r: R) -> Matrix<n, m, R> {
        return Matrix{ (i, j) in a[i, j] * r }
    }
    
    public static func * <p>(a: Matrix<n, m, R>, b: Matrix<m, p, R>) -> Matrix<n, p, R> {
        return Matrix<n, p, R>{ (i, k) in
            (0 ..< a.cols).sum { j in a[i, j] * b[j, k] }
        }
    }
    
    public var transposed: Matrix<m, n, R> {
        return Matrix<m, n, R>{ (i, j) in self[j, i] }
    }
    
    public func map<R2>(_ f: (R) -> R2) -> Matrix<n, m, R2> {
        return Matrix<n, m, R2>(grid.map(f))
    }
    
    public var hashValue: Int {
        return 0 // TODO
    }
    
    public var description: String {
        return "[" + (0 ..< rows).map({ i in
            return (0 ..< cols).map({ j in
                return "\(self[i, j])"
            }).joined(separator: ", ")
        }).joined(separator: "; ") + "]"
    }
    
    public var detailDescription: String {
        if (rows, cols) == (0, 0) {
            return "[]"
        } else if rows == 0 {
            return "[" + String(repeating: "\t,", count: cols - 1) + "\t]"
        } else if cols == 0 {
            return "[" + String(repeating: "\t;", count: rows - 1) + "\t]"
        } else {
            return "[\t" + (0 ..< rows).map({ i in
                return (0 ..< cols).map({ j in
                    return "\(self[i, j])"
                }).joined(separator: ",\t")
            }).joined(separator: "\n\t") + "]"
        }
    }
    
    public static var symbol: String {
        let (rows, cols) = (n.intValue, m.intValue)
        switch (rows, cols) {
        case (_, 1): return "cVec<\(rows); \(R.symbol)>"
        case (1, _): return "rVec<\(cols); \(R.symbol)>"
        default:     return "Mat<\(rows), \(cols); \(R.symbol)>"
        }
    }
}

extension Matrix: VectorSpace, FiniteDimVectorSpace where R: Field {
    public static var dim: Int {
        return n.intValue * m.intValue
    }
    
    public static var standardBasis: [Matrix<n, m, R>] {
        return (0 ..< n.intValue).flatMap { i -> [Matrix<n, m, R>] in
            (0 ..< m.intValue).map { j -> Matrix<n, m, R> in
                Matrix.unit(i, j)
            }
        }
    }
    
    public var standardCoordinates: [R] {
        return grid
    }
}

public extension Matrix where R == 𝐑 {
    public var asComplex: Matrix<n, m, 𝐂> {
        return Matrix<n, m, 𝐂>(grid.map{ $0.asComplex })
    }
}

public extension Matrix where R == 𝐂 {
    public var realPart: Matrix<n, m, 𝐑> {
        return Matrix<n, m, 𝐑>(grid.map{ $0.realPart })
    }
    
    public var imaginaryPart: Matrix<n, m, 𝐑> {
        return Matrix<n, m, 𝐑>(grid.map{ $0.imaginaryPart })
    }
    
    public var adjoint: Matrix<m, n, R> {
        return Matrix<m, n, R>(transposed.grid.map{ $0.conjugate })
    }
}
