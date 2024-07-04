
import SwiftUI

@propertyWrapper
public struct UserDefault<Key, Value> where Key: RawRepresentable<String> {
    let key: Key
    let defaultValue: Value?
    let userDefaults: UserDefaults

    public var wrappedValue: Value? {
        get { (userDefaults.object(forKey: key.rawValue) as? Value) ?? defaultValue }
        set { userDefaults.setValue(newValue, forKey: key.rawValue) }
    }
    
    public init(wrappedValue: Value? = nil, userDefaults: UserDefaults = .standard, _ key: Key) {
        self.defaultValue = wrappedValue
        self.userDefaults = userDefaults
        self.key = key
    }
}

@propertyWrapper
public struct CodableUserDefault<Key, Value> where Key: RawRepresentable<String>, Value: Codable {
    let key: Key
    let defaultValue: Value?
    let userDefaults: UserDefaults

    public var wrappedValue: Value? {
        get { getValue() }
        set { save(newValue) }
    }
    
    public init(wrappedValue: Value? = nil, userDefaults: UserDefaults = .standard, _ key: Key) {
        self.defaultValue = wrappedValue
        self.userDefaults = userDefaults
        self.key = key
    }
    
    private func getValue() -> Value? {
        guard
            let data = userDefaults.value(forKey: key.rawValue) as? Data,
            let object = try? JSONDecoder().decode(Value.self, from: data)
        else { return nil }
        
        return object
    }
    
    private func save(_ value: Value?) {
        guard let value else {
            userDefaults.removeObject(forKey: key.rawValue)
            return
        }
        
        let data = try? JSONEncoder().encode(value)
        userDefaults.setValue(data, forKey: key.rawValue)
    }
}
