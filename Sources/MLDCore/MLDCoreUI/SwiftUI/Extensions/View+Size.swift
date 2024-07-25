
import SwiftUI

public extension View {
    /// Sets the frame's maxWidth property to ``infinity``
    func maxWidth() -> some View {
        frame(maxWidth: .infinity)
    }
    
    /// Sets the frame's maxHeight property to ``infinity``
    func maxHeight() -> some View {
        frame(maxHeight: .infinity)
    }
    
    /// Sets the frame's maxWidth and maxHeight properties to ``infinity``
    func maxWidthAndHeight() -> some View {
        maxWidth().maxHeight()
    }
}
