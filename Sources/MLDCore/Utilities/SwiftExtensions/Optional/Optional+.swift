
import Foundation

public extension Optional<Sequence> {
    var orEmpty: Wrapped {
        self ?? []
    }
}
public extension Optional<String> {
    var orEmpty: Wrapped {
        self ?? ""
    }
}
