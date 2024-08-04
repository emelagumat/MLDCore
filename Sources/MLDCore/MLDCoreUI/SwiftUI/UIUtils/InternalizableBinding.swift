
import SwiftUI

@propertyWrapper
struct InternalizableBinding<Item> {
    private let internalValue: InternalValue<Item>
    var projectedValue: Binding<Item>
    var wrappedValue: Item {
        get { internalValue.value }
        set { internalValue.value = newValue }
    }
    
}

extension InternalizableBinding {
    init(wrappedValue: Item) {
        let internalValue = InternalValue(value: wrappedValue)
        self.internalValue = internalValue
        self.projectedValue = .init(
            get: {
                internalValue.value
            }, set: {
                internalValue.value = $0
            }
        )
    }
    init(projectedValue: Binding<Item>) {
        let internalValue = InternalValue(value: projectedValue.wrappedValue)
        self.internalValue = internalValue
        self.projectedValue = projectedValue
        
        
    }
}

class InternalValue<Value>: ObservableObject {
    var value: Value
    
    init(value: Value) {
        self.value = value
    }
}
