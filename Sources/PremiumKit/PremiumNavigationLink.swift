import SwiftUI

public struct PremiumNavigationLink<Destination: View, StoreView: View, Label: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.isLockable)
    var isLockable
    
    let destination: () -> Destination
    
    let storeView: () -> StoreView
    
    let label: () -> Label
    
    public init(
        destination: @escaping () -> Destination,
        storeView: @escaping () -> StoreView,
        label: @escaping () -> Label
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
