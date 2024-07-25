
import SwiftUI

struct MultiplatformSheetModifier<Sheet: View>: ViewModifier {
    var macOSWidth: CGFloat = 540
    var macOSHeight: CGFloat = 540
    var isPresented: Binding<Bool>
    @ViewBuilder var sheet: Sheet
    
    func body(content: Content) -> some View {
#if os(iOS)
        content
            .sheet(isPresented: isPresented, content: {
                sheet
            })
#elseif os(macOS)
        content
            .sheet(isPresented: isPresented, content: {
                VStack(spacing: .zero) {
                    sheet
                    Button(
                        action: {
                            isPresented.wrappedValue = false
                        }, label: {
                            Text("common_ok")
                                .padding(4)
                        }
                    )
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                .frame(width: macOSWidth, height: macOSHeight, alignment: .center)
                .ignoresSafeArea()
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
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: () -> Sheet
    ) -> some View {
        self.modifier(MultiplatformSheetModifier(macOSWidth: macOSWidth, macOSHeight: macOSHeight, isPresented: isPresented, sheet: sheet))
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
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: () -> Sheet
    ) -> some View {
        self.modifier(MultiplatformSheetModifier(macOSWidth: size, macOSHeight: size, isPresented: isPresented, sheet: sheet))
    }
}
