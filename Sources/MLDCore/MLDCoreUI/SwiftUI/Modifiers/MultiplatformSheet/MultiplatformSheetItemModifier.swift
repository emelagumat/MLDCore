import SwiftUI

struct MultiplatformSheetItemModifier<Item, Sheet: View>: ViewModifier where Item: Hashable {
    var macOSWidth: CGFloat = 540
    var macOSHeight: CGFloat = 540
    var item: Binding<Item?>
    @ViewBuilder var sheet: (Item) -> Sheet
    
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        content
            .multiplatformSheet(
                macOSWidth: macOSWidth,
                macOSHeight: macOSHeight,
                isPresented: $isPresented,
                sheet: {
                    if let item = item.wrappedValue {
                        sheet(item)
                    }
                }
            )
            .onAppear {
                isPresented = item.wrappedValue != nil
            }
            .onChange(of: item.wrappedValue) { newItem in
                isPresented = newItem != nil
            }
            .onChange(of: isPresented) { old, isPresented in
                if !isPresented {
                    item.wrappedValue = nil
                }
            }
    }
}

public extension View {
    /**
     Presents a sheet on multiple platforms when the item is not nil.
     
     For macOS, the sheet is presented with a fixed size and an "OK" button at the bottom.
     
     - Parameters:
       - macOSWidth: The width to be used on macOS. Default is 540.
       - macOSHeight: The height to be used on macOS. Default is 540.
       - item: A binding to the item controlling whether to show the sheet.
     */
    func multiplatformSheet<Item: Hashable, Sheet: View>(
        macOSWidth: CGFloat = 540,
        macOSHeight: CGFloat = 540,
        item: Binding<Item?>,
        @ViewBuilder sheet: @escaping (Item) -> Sheet
    ) -> some View {
        self.modifier(MultiplatformSheetItemModifier(macOSWidth: macOSWidth, macOSHeight: macOSHeight, item: item, sheet: sheet))
    }
    
    /**
     Presents a sheet on multiple platforms when the item is not nil.
     
     For macOS, the sheet is presented with a fixed size and an "OK" button at the bottom.
     
     - Parameters:
       - size: The width and height to be used on macOS. Default is 540.
       - item: A binding to the item controlling whether to show the sheet.
     */
    func multiplatformSheet<Item: Hashable, Sheet: View>(
        size: CGFloat = 540,
        item: Binding<Item?>,
        @ViewBuilder sheet: @escaping (Item) -> Sheet
    ) -> some View {
        self.modifier(MultiplatformSheetItemModifier(macOSWidth: size, macOSHeight: size, item: item, sheet: sheet))
    }
}
