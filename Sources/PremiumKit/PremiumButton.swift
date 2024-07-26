import SwiftUI

public struct PremiumButton<Label: View, StoreView: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.isLockable)
    var isLockable
    
    @State
    var isPresented: Bool = false
    
    let action: () -> Void
    
    @ViewBuilder
    let storeView: () -> StoreView
    
    @ViewBuilder
    let label: () -> Label
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder storeView: @escaping () -> StoreView) {
        self.action = action
        self.label = label
        self.storeView = storeView
    }
    
    public var body: some View {
        Button(action: buttonAction, label: {
            PremiumLabel(label: label)
        })
        .sheet(isPresented: $isPresented) {
            storeView()
        }
    }
    
    func buttonAction() {
        switch (isLockable, isPremium) {
        case (true, false):
            isPresented.toggle()
        default:
            action()
        }
    }
}
