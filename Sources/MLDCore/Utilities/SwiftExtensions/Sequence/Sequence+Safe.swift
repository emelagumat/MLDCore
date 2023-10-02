
public extension Array {
    subscript(safe index: Int) -> Element? {
        if index >= count { return nil }
        return self[index]
    }
}
