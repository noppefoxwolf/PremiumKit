import SwiftUI

public struct PremiumPicker<SelectionValue: Hashable, Content: View, Label: View, StoreView: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.featureIdentifier)
    var featureIdentifier
    
    @State
    var isPresented: Bool = false
    
    @Binding
    var selection: SelectionValue
    
    @ViewBuilder
    let storeView: (String) -> StoreView
    
    @ViewBuilder
    let label: () -> Label
    
    @ViewBuilder
    let content: () -> Content
    
    public init(
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder storeView: @escaping (String) -> StoreView) {
        self._selection = selection
        self.content = content
        self.label = label
        self.storeView = storeView
    }
    
    public var body: some View {
        if isPremium {
            Picker(selection: _selection, content: content, label: label)
        } else {
            Button(action: {
                isPresented.toggle()
            }, label: {
                LockedLabel(label: label)
            })
            .sheet(isPresented: $isPresented) {
                storeView(featureIdentifier)
            }
        }
    }
}

