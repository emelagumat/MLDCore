
import Foundation

/// Represents commonly used time frequencies.
public enum Frequency: CaseIterable {
    /// Represents an hourly frequency.
    case hourly
    /// Represents a daily frequency.
    case daily
    /// Represents a monthly frequency.
    case monthly
    /// Represents a yearly frequency.
    case yearly
}


public extension Frequency {
    /// Converts the `Frequency` value to its corresponding `Calendar.Component`.
    var rawValue: Calendar.Component {
        switch self {
        case .hourly:
            return .hour
        case .daily:
            return .day
        case .monthly:
            return .month
        case .yearly:
            return .year
        }
    }
    
    var name: String {
        switch self {
        case .hourly:
            return "hour"
        case .daily:
            return "day"
        case .monthly:
            return "month"
        case .yearly:
            return "year"
        }
    }
}

public extension Frequency {
    /// Initializes a `Frequency` using a given `Calendar.Component`.
    ///
    /// - Parameter rawValue: The `Calendar.Component` value to convert.
    /// - Returns: A `Frequency` value if the conversion is successful; otherwise, `nil`.
    init?(rawValue: Calendar.Component) {
        switch rawValue {
        case .hour:
            self = .hourly
        case .day:
            self = .daily
        case .month:
            self = .monthly
        case .year:
            self = .yearly
        default:
            return nil
        }
    }
}
