
@MainActor
public protocol ViewModel {
    associatedtype State: ViewStateWrapper
    associatedtype ViewAction
    
    var state: State { get set }
    func send(_ action: ViewAction)
}

public protocol ViewStateWrapper: Sendable {
    associatedtype ViewState: Sendable
    
    var viewState: ViewState? { get }
    static func loaded(_ viewState: ViewState) -> Self
}

public extension ViewModel {
    var viewState: State.ViewState? {
        get { state.viewState }
        set { if let newValue { state = .loaded(newValue) } }
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<State.ViewState, T>) -> T? {
        viewState?[keyPath: keyPath]
    }
    
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<State.ViewState, T>) -> T? {
        get {
            viewState?[keyPath: keyPath]
        }
        set {
            guard var viewState, let newValue else { return }
            viewState[keyPath: keyPath] = newValue
            state = .loaded(viewState)
        }
    }
}
