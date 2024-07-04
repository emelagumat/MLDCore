
import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        if index >= count { return nil }
        return self[index]
    }
}

public extension Collection where Element: Hashable {
    func withoutDuplicates() -> [Element] {
        Array(Set(self))
    }
}

public extension Collection {
    func withoutDuplicates<T: Equatable>(of keypath: KeyPath<Element, T>) -> [Element] {
        var includedValues: [T] = []
        var output: [Element] = []
        
        for element in self {
            let equatableValue = element[keyPath: keypath]
            if !includedValues.contains(equatableValue) {
                includedValues.append(equatableValue)
                output.append(element)
            }
        }
        
        return output
    }
    
    func withoutDuplicates<T: Equatable>(_ transform: (Element) -> T) -> [Element] {
        var includedValues: [T] = []
        var output: [Element] = []
        
        for element in self {
            let equatableValue = transform(element)
            if !includedValues.contains(equatableValue) {
                includedValues.append(equatableValue)
                output.append(element)
            }
        }
        
        return output
    }
}
