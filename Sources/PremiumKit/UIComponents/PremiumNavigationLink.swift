import SwiftUI

public struct PremiumNavigationLink<Destination: View, StoreView: View, Label: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.isLockable)
    var isLockable
    
    @Environment(\.featureIdentifier)
    var featureIdentifier
    
    @State
    var isPresented: Bool = false
    
    @ViewBuilder 
    let destination: () -> Destination
    
    @ViewBuilder
    let storeView: (String) -> StoreView
    
    @ViewBuilder
    let label: () -> Label
    
    public init(
        @ViewBuilder destination: @escaping () -> Destination,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder storeView: @escaping (String) -> StoreView
    ) {
        self.destination = destination
        self.label = label
        self.storeView = storeView
    }
    
    public var body: some View {
        switch (isLockable, isPremium) {
        case (true, false):
            Button(action: {
                isPresented.toggle()
            }, label: {
                LockedLabel(label: label)
            })
            .sheet(isPresented: $isPresented) {
                storeView(featureIdentifier)
            }
        default:
            NavigationLink(
                destination: destination,
                label: {
                    PremiumLabel(label: label)
                }
            )
        }
    }
}
