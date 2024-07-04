import Foundation

/// Represents a measurement of length.
public typealias LenghtMeasurement = Measurement<UnitLength>

/// Represents a measurement of volume.
public typealias VolumeMeasurement = Measurement<UnitVolume>

/// Represents a measurement of duration.
public typealias DurationMeasurement = Measurement<UnitDuration>

public extension Measurement where UnitType: Dimension {
    
    /// Converts the current measurement value to a specified unit.
    ///
    /// - Parameter unit: The target unit to which the measurement will be converted.
    /// - Returns: The value of the current measurement after conversion to the specified unit.
    func value(in unit: UnitType) -> Double {
        return self.converted(to: unit).value
    }
}

extension Calendar.Component {
    static let frequencyCases: [Calendar.Component] = [
        .hour,
        .day,
        .month,
        .year
    ]
}
