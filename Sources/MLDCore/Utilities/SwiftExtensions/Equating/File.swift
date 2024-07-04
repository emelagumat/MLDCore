
public struct Equating<Z> {
    public let equals: (Any) -> Bool
}

public extension Equating where Z: Equatable {
    static func checkIf(_ value: Z) -> Equating<Z> {
        .init { lhs in
            if let lhsAsZ = lhs as? Z {
                return lhsAsZ == value
            }
            return false
        }
    }
}

public extension Equatable {
    func equals(_ anyValue: Any) -> Bool {
        Equating
            .checkIf(self)
            .equals(anyValue)
    }
}

public extension Array where Element == any Equatable {
    func equals(_ anyArray: [Any]) -> Bool {
        guard
            self.count == anyArray.count
        else { return false }
        
        for (lhs, rhs) in zip(self, anyArray) {
            if !lhs.equals(rhs) {
                return false
            }
        }
        return true
    }
}
