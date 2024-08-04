
import SwiftUI

struct MultiplatformSheetModifier<Sheet: View>: ViewModifier {
    var macOSWidth: CGFloat
    var macOSHeight: CGFloat
    var iOSPresentationDetents: Set<PresentationDetent>?
    var isPresented: Binding<Bool>
    @ViewBuilder var sheet: Sheet
    
    private var isIpad: Bool {
        #if os(iOS)
        UIDevice.current.userInterfaceIdiom == .pad
        #elseif os(macOS)
        false
        #endif
    }
    
    var presentationDetents: Set<PresentationDetent>? {
        isIpad ? nil : iOSPresentationDetents
    }
    
    func body(content: Content) -> some View {
#if os(iOS)
        content
            .sheet(isPresented: isPresented, content: {
                if let presentationDetents {
                    sheet
                        .presentationDetents(presentationDetents)
                } else {
                    sheet
                }
            })
#elseif os(macOS)
        content
            .sheet(isPresented: isPresented, content: {
                VStack(spacing: .zero) {
                    sheet
                    Spacer()
                    Button(
                        action: {
                            isPresented.wrappedValue = false
                        }, label: {
                            Text("common_ok")
                                .padding(2)
                        }
                    )
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding(4)
                }
                .frame(width: macOSWidth, height: macOSHeight, alignment: .center)
            })
#endif
    }
}

public extension View {
    /**
     Presents a sheet on multiple platforms depending on ``isPresented``  value
     
     For macOS, the sheet is presented with a fixed size and an "OK" button at the bottom
     
     - Parameters:
     - macOSWidth: The width to be used on macOS. Default is 540
     - macOSHeight: The width to be used on macOS. Default is 540
     - isPresented: A binding to decide wether to show the sheet
     */
    func multiplatformSheet<Sheet: View>(
        macOSWidth: CGFloat = 540,
        macOSHeight: CGFloat = 540,
        iOSPresentationDetents: Set<PresentationDetent>? = nil,
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: () -> Sheet
    ) -> some View {
        self.modifier(
            MultiplatformSheetModifier(
                macOSWidth: macOSWidth,
                macOSHeight: macOSHeight,
                iOSPresentationDetents: iOSPresentationDetents,
                isPresented: isPresented,
                sheet: sheet
            )
        )
    }
    
    /**
     Presents a sheet on multiple platforms depending on ``isPresented``  value
     
     For macOS, the sheet is presented with a fixed size and an "OK" button at the bottom
     
     - Parameters:
     - size: The width and height to be used on macOS. Default is 540
     - isPresented: A binding to decide wether to show the sheet
     */
    func multiplatformSheet<Sheet: View>(
        size: CGFloat = 540,
        iOSPresentationDetents: Set<PresentationDetent>? = nil,
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: () -> Sheet
    ) -> some View {
        self.modifier(
            MultiplatformSheetModifier(
                macOSWidth: size,
                macOSHeight: size,
                iOSPresentationDetents: iOSPresentationDetents,
                isPresented: isPresented,
                sheet: sheet
            )
        )
    }
}

@propertyWrapper struct Observed {
    typealias Value = any Observable
    var wrappedValue: Value
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

@Observable
final class DataSource: Sendable, ObservableObject {
    var id = "ha"
}

