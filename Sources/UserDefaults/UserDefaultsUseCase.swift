
import Foundation

public protocol UserDefaultsUseCaseContract {
    associatedtype Key: RawRepresentable where Key.RawValue == String
    
    func value<T>(for key: Key) -> T?
    func set<T>(_ value: T?, for key: Key)
}

public protocol UserDefaultsRepositoryContract {
    associatedtype Key: RawRepresentable where Key.RawValue == String
    
    func value<T>(for key: Key) -> T?
    func set<T>(_ value: T?, for key: Key)
}

public final class UserDefaultsUseCase<Key: RawRepresentable, Repository: UserDefaultsRepositoryContract>: UserDefaultsUseCaseContract where Key.RawValue == String, Repository.Key == Key {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public init() {
        self.repository = DefaultUserDefaultsRepository<Key>() as! Repository
    }
    
    public func value<T>(for key: Key) -> T? {
        repository.value(for: key)
    }
    
    public func set<T>(_ value: T?, for key: Key) {
        repository.set(value, for: key)
    }
}

public final class DefaultUserDefaultsRepository<Key: RawRepresentable>: UserDefaultsRepositoryContract where Key.RawValue == String {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func value<T>(for key: Key) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }
    
    public func set<T>(_ value: T?, for key: Key) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }
}
