
import SwiftUI

public struct Toast: Equatable {
    public var style: ToastStyle
    public var message: String
    public var duration: Double = 3
    public var width: Double = .infinity
    public var performHapticFeedbacks: Bool = true
    
    public init(style: ToastStyle, message: String, duration: Double = 3, width: Double = .infinity, performHapticFeedbacks: Bool = true) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
        self.performHapticFeedbacks = performHapticFeedbacks
    }
}

public enum ToastStyle {
    case error
    case warning
    case success
    case info
}

public extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return ToastStyle.errorColor
        case .warning: return ToastStyle.warningColor
        case .info: return ToastStyle.infoColor
        case .success: return ToastStyle.successColor
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return ToastStyle.infoIcon
        case .warning: return ToastStyle.warningIcon
        case .success: return ToastStyle.successIcon
        case .error: return ToastStyle.errorIcon
        }
    }
}

public extension ToastStyle {
    static var errorColor = Color.red
    static var warningColor = Color.orange
    static var infoColor = Color.blue
    static var successColor = Color.green
    
    
    static var infoIcon = "info.circle.fill"
    static var warningIcon = "exclamationmark.triangle.fill"
    static var successIcon = "checkmark.circle.fill"
    static var errorIcon = "xmark.circle.fill"
}
