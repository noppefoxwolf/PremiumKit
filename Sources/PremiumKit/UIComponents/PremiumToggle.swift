import SwiftUI

public struct PremiumToggle<Label: View, StoreView: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @State
    var isPresented: Bool = false
    
    @Binding
    var isOn: Bool
    
    @ViewBuilder
    let storeView: () -> StoreView
    
    @ViewBuilder
    let label: () -> Label
    
    public init(
        isOn: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder storeView: @escaping () -> StoreView) {
        self._isOn = isOn
        self.label = label
        self.storeView = storeView
    }
    
    public var body: some View {
        if isPremium {
            Toggle(isOn: _isOn, label: label)
        } else {
            Button(action: {
                isPresented.toggle()
            }, label: {
                LockedLabel(label: label)
            })
            .sheet(isPresented: $isPresented) {
                storeView()
            }
        }
    }
}
