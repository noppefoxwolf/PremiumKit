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
        @ViewBuilder storeView: @escaping () -> StoreView,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.destination = destination
        self.storeView = storeView
        self.label = label
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
