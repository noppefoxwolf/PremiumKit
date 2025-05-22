import StoreKit
import SwiftUI
import PremiumKit

extension PremiumButton where StoreView == DefaultStoreView {
    public init(action: @escaping () -> Void, label: @escaping () -> Label) {
        self.init(
            action: action,
            label: label,
            storeView: { featureIdentifier in
                DefaultStoreView(featureIdentifier: featureIdentifier)
            }
        )
    }
}

extension PremiumPicker where StoreView == DefaultStoreView {
    public init(selection: Binding<SelectionValue>, content: @escaping () -> Content, label: @escaping () -> Label) {
        self.init(
            selection: selection,
            content: content,
            label: label,
            storeView: { featureIdentifier in
                DefaultStoreView(featureIdentifier: featureIdentifier)
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
            label: label,
            storeView: { featureIdentifier in
                DefaultStoreView(featureIdentifier: featureIdentifier)
            }
        )
    }
}

public struct DefaultStoreView: View {
    let featureIdentifier: String
    
    public var body: some View {
        if let feature = ExampleFeature(rawValue: featureIdentifier) {
            StoreKit.SubscriptionStoreView(
                productIDs: ["dev.noppe.example.monthly", "dev.noppe.example.annually"],
                marketingContent: {
                    Text(feature.rawValue)
                }
            )
        } else {
            StoreKit.SubscriptionStoreView(
                productIDs: ["dev.noppe.example.monthly", "dev.noppe.example.annually"],
            )
        }
    }
}

enum ExampleFeature: String {
    case appIcon
}
