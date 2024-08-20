import SwiftUI

public struct PremiumNavigationLink<Destination: View, StoreView: View, Label: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.isLockable)
    var isLockable
    
    @ViewBuilder 
    let destination: () -> Destination
    
    @ViewBuilder
    let storeView: () -> StoreView
    
    @ViewBuilder
    let label: () -> Label
    
    public init(
        @ViewBuilder destination: @escaping () -> Destination,
        @ViewBuilder label: @escaping () -> Label,
        @ViewBuilder storeView: @escaping () -> StoreView
    ) {
        self.destination = destination
        self.label = label
        self.storeView = storeView
    }
    
    public var body: some View {
        NavigationLink(
            destination: {
                linkDestination()
            },
            label: {
                PremiumLabel(label: label)
            }
        )
    }
    
    @ViewBuilder
    func linkDestination() -> some View {
        switch (isLockable, isPremium) {
        case (true, false):
            storeView()
        default:
            destination()
        }
    }
}
