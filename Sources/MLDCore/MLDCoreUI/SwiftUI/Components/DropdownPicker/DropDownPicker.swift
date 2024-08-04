
import SwiftUI

struct Sample: View {
    var body: some View {
        Text("Sample")
    }
}

#Preview {
    Sample()
}
//
//public struct DropDownSectionPicker<Item: Identifiable, Title: View, Label: View, Row: View>: View {
//    @State private var internalIsExpanded: Bool
//    private var externalIsExpanded: Binding<Bool>?
//    private var isExpanded: Binding<Bool> {
//        externalIsExpanded ?? $internalIsExpanded
//    }
//    
//    @State private var fixedItems: [IdentifiableSection<Item>]
//    private var bindedItems: Binding<[IdentifiableSection<Item>]>?
//    var items: Binding<[IdentifiableSection<Item>]> {
//        bindedItems ?? $fixedItems
//    }
//    
//    
//    @State private var internalSelection: [Item.ID]
//    private var externalSelection: Binding<[Item.ID]>?
//    private var selection: Binding<[Item.ID]> {
//        externalSelection ?? $internalSelection
//    }
//    
//    @ViewBuilder 
//    private var title: () -> Title
//    @ViewBuilder private var sectionLabel: (IdentifiableSection<Item>) -> Label
//    @ViewBuilder private var row: (Binding<Item>) -> Row
//    
//    var selectedIconName = "checkmark"
//    
//    public var body: some View {
//        DisclosureGroup(isExpanded: isExpanded) {
//            ForEach(items) { section in
//                DropDownPicker(
//                    items: section.items,
//                    selection: selection,
//                    label: { labelSections in
//                        sectionLabel(section.wrappedValue)
//                    },
//                    forEach: { item in
//                        row(item)
////                            .onTapGesture {
////                                toggleIsSelected(item.wrappedValue)
////                            }
//                    })
//            }
//        } label: {
//            title()
//        }
//    }
//    
//    private func isSelected(_ item: Item) -> Bool {
//        selection.wrappedValue.contains(item.id)
//    }
//    
//    private func toggleIsSelected(_ item: Item) {
//        if isSelected(item) {
//            if let index = selection.wrappedValue.firstIndex(where: { $0 == item.id }) {
//                selection.wrappedValue.remove(at: index)
//            }
//        } else {
//            selection.wrappedValue.append(item.id)
//        }
//    }
//}
//
//struct SelectableRow<Content: View>: View {
//    let isSelected: Bool
//    var selectedIconName = "checkmark"
//    @ViewBuilder
//    var content: () -> Content
//    var onTap: () -> ()
//    var body: some View {
//        HStack {
//            content()
//            Spacer()
//            if isSelected {
//                Image(systemName: selectedIconName)
//            }
//        }
//        .background()
//        .onTapGesture {
//            withAnimation {
//                onTap()
//            }
//        }
//    }
//}
//public struct DropDownPicker<Item: Identifiable, Label: View, Row: View>: View {
//    @State private var internalIsExpanded: Bool
//    private var externalIsExpanded: Binding<Bool>?
//    private var isExpanded: Binding<Bool> {
//        externalIsExpanded ?? $internalIsExpanded
//    }
//    
//    @State private var fixedItems: [Item]
//    private var bindedItems: Binding<[Item]>?
//    var items: Binding<[Item]> {
//        bindedItems ?? $fixedItems
//    }
//    
//    
//    @State private var internalSelection: [Item.ID]
//    private var externalSelection: Binding<[Item.ID]>?
//    private var selection: Binding<[Item.ID]> {
//        externalSelection ?? $internalSelection
//    }
//    
//    @ViewBuilder private var row: (Binding<Item>) -> Row
//    @ViewBuilder private var label: (Binding<[Item]>) -> Label
//    
//    var selectedIconName = "checkmark"
//    
//    public var body: some View {
//        DisclosureGroup(
//            isExpanded: isExpanded) {
//                List(items) { item in
//                    VStack(alignment: .leading) {
////                        SelectableRow(
////                            isSelected: isSelected(item.wrappedValue),
////                            content: {
////                                row(item)
////                            },
////                            onTap: {
////                                toggleIsSelected(item.wrappedValue)
////                            })
//                        HStack {
//                            row(item)
//                            Spacer()
//                                .background(.red)
//                                .maxWidthAndHeight()
//                                .clipShape(Rectangle())
//                            if isSelected(item.wrappedValue) {
//                                Image(systemName: selectedIconName)
//                            }
//                        }
//                        .background()
//                        .onTapGesture {
//                            withAnimation {
//                                toggleIsSelected(item.wrappedValue)
//                            }
//                        }
//                    }
//                }
//            } label: {
//                label(items)
//            }
//    }
//    
//    private func isSelected(_ item: Item) -> Bool {
//        selection.wrappedValue.contains(item.id)
//    }
//    
//    private func toggleIsSelected(_ item: Item) {
//        if isSelected(item) {
//            if let index = selection.wrappedValue.firstIndex(where: { $0 == item.id }) {
//                selection.wrappedValue.remove(at: index)
//            }
//        } else {
//            selection.wrappedValue.append(item.id)
//        }
//    }
//}
//
//// MARK: - Inits
//public extension DropDownPicker {
//    init(
//        items: [Item],
//        isExpanded: Bool = false,
//        selection: [Item.ID] = [],
//        @ViewBuilder  label:  @escaping (Binding<[Item]>) -> Label,
//        @ViewBuilder forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.label = label
//        self.row = row
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection
//        self.externalSelection = nil
//    }
//    
//    init(
//        items: [Item],
//        isExpanded: Bool = false,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  label:  @escaping (Binding<[Item]>) -> Label,
//        @ViewBuilder forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.label = label
//        self.row = row
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//    }
//    
//    init(
//        items: [Item],
//        isExpanded: Binding<Bool>,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  label:  @escaping (Binding<[Item]>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.label = label
//        self.row = row
//        self.internalIsExpanded = isExpanded.wrappedValue
//        self.externalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//        
//    }
//    
//    init(
//        items: Binding<[Item]>,
//        isExpanded: Bool = false,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  label:  @escaping (Binding<[Item]>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.bindedItems = items
//        self.label = label
//        self.row = row
//        self.fixedItems = items.wrappedValue
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//        
//    }
//    
//    init(
//        items: Binding<[Item]>,
//        isExpanded: Binding<Bool>,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  label:  @escaping (Binding<[Item]>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.bindedItems = items
//        self.label = label
//        self.row = row
//        self.fixedItems = items.wrappedValue
//        self.internalIsExpanded = isExpanded.wrappedValue
//        self.externalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//    }
//}
//
//// MARK: - Inits
//public extension DropDownSectionPicker {
//    init(
//        items: [IdentifiableSection<Item>],
//        isExpanded: Bool = false,
//        selection: [Item.ID] = [],
//        @ViewBuilder  title: @escaping () -> Title,
//        @ViewBuilder  sectionLabel: @escaping (IdentifiableSection<Item>) -> Label,
//        @ViewBuilder forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.title = title
//        self.sectionLabel = sectionLabel
//        self.row = row
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection
//        self.externalSelection = nil
//    }
//    
//    init(
//        items: [IdentifiableSection<Item>],
//        isExpanded: Bool = false,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  title: @escaping () -> Title,
//        @ViewBuilder  sectionLabel: @escaping (IdentifiableSection<Item>) -> Label,
//        @ViewBuilder forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.sectionLabel = sectionLabel
//        self.title = title
//        self.row = row
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//    }
//    
//    init(
//        items: [IdentifiableSection<Item>],
//        isExpanded: Binding<Bool>,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  title: @escaping () -> Title,
//        @ViewBuilder  sectionLabel: @escaping (IdentifiableSection<Item>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.fixedItems = items
//        self.sectionLabel = sectionLabel
//        self.title = title
//        self.row = row
//        self.internalIsExpanded = isExpanded.wrappedValue
//        self.externalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//        
//    }
//    
//    init(
//        items: Binding<[IdentifiableSection<Item>]>,
//        isExpanded: Bool = false,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  title: @escaping () -> Title,
//        @ViewBuilder  sectionLabel: @escaping (IdentifiableSection<Item>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.bindedItems = items
//        self.sectionLabel = sectionLabel
//        self.title = title
//        self.row = row
//        self.fixedItems = items.wrappedValue
//        self.internalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//        
//    }
//    
//    init(
//        items: Binding<[IdentifiableSection<Item>]>,
//        isExpanded: Binding<Bool>,
//        selection: Binding<[Item.ID]>,
//        @ViewBuilder  title: @escaping () -> Title,
//        @ViewBuilder  sectionLabel: @escaping (IdentifiableSection<Item>) -> Label,
//        @ViewBuilder  forEach row: @escaping (Binding<Item>) -> Row
//    ) {
//        self.bindedItems = items
//        self.sectionLabel = sectionLabel
//        self.title = title
//        self.row = row
//        self.fixedItems = items.wrappedValue
//        self.internalIsExpanded = isExpanded.wrappedValue
//        self.externalIsExpanded = isExpanded
//        self.internalSelection = selection.wrappedValue
//        self.externalSelection = selection
//    }
//}
//
//
//#Preview {
//    struct SamplePreview: View {
//        @State var sections: [IdentifiableSection<Mec>] = IdentifiableSection<Mec>.mock
//        @State var items: [Mec] = (0...10).map { .init(text: "\($0)") }
//        @State var selection: [Mec.ID] = []
//        @State var isExpandedPicker2 = false
//        @State var isExpandedPicker3 = true
//        
//        var body: some View {
//            Form {
//                picker1
//                picker2
//                picker3
//            }
//        }
//        
//        @ViewBuilder var picker1: some View {
//            DropDownPicker(
//                items: $items,
//                selection: $selection,
//                label: { items in
//                    HStack {
//                        Text("Section \(items.count)")
//                    }
//                },
//                forEach: { item in
//                    
//                    Text("Item \(item.wrappedValue.text)")
//                }
//            )
//        }
//        
//        @ViewBuilder var picker2: some View {
//            DropDownPicker(
//                items: items,
//                isExpanded: $isExpandedPicker2,
//                selection: $selection,
//                label: { items in
//                    HStack {
//                        Text("Section \(items.count)")
//                    }
//                },
//                forEach: { item in
//                    
//                    Text("Item \(item.wrappedValue.text)")
//                }
//            )
//        }
//        
//        
//        @ViewBuilder var picker3: some View {
//            DropDownSectionPicker(
//                items: sections,
//                isExpanded: false,
//                selection: $selection,
//                title: {
//                    HStack {
//                        Text("Picker3")
//                    }
//                },
//                sectionLabel: { section in
//                    HStack {
//                        Text("Section \(section.id)")
//                    }
//                },
//                forEach: { item in
//                    Text("Sect \(item.wrappedValue.text)")
//                }
//            )
//        }
//    }
//    return SamplePreview()
//}
//
//struct Mec: Identifiable {
//    var id: String { text }
//    let text: String
//}
//
//extension IdentifiableSection {
//    static var mock: [IdentifiableSection<Mec>] {
//        (0...4).map { index in
//            let sections = (0...5).map { Mec(text: "Item \(index).\($0)") }
//            return IdentifiableSection<Mec>(id: "\(index)", items: sections)
//        }
//    }
//}
//
//public struct IdentifiableSection<Item>: Identifiable {
//    public let id: String
//    var items: [Item]
//}
