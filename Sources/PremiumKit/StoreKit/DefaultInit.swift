import StoreKit
import SwiftUI

extension PremiumButton where StoreView == DefaultStoreView {
    public init(action: @escaping () -> Void, label: @escaping () -> Label) {
        self.init(
            action: action,
            label: label,
            storeView: {
                DefaultStoreView()
            }
        )
    }
}

extension PremiumNavigationLink where StoreView == DefaultStoreView {
    public init(
        destination: @escaping () -> Destination,
        label: @escaping () -> Label
    ) {
        self.init(
            destination: destination,
            storeView: {
                DefaultStoreView()
            },
            label: label
        )
    }
}

public struct DefaultStoreView: View {
    public var body: some View {
        StoreKit.StoreView(ids: [])
    }
}
