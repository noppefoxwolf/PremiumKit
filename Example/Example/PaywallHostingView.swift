import SwiftUI
import PremiumKit
import StoreKit

@Observable
final class PaywallHostingViewModel {
    enum State: Equatable {
        case loading
        case purchased(StoreKit.Product)
        case purchasable([StoreKit.Product])
        case unavailable
    }
    let subscriptionProductIDs = [
        "dev.noppe.snowfox.monthly",
        "dev.noppe.snowfox.yearly",
    ]
    let lifetimeProductID = "dev.noppe.snowfox.lifetime"
    
    var error: (any Error)? = nil
    var configuration: PaywallViewConfiguration? = nil
    
    var availableProducts: [StoreKit.Product] = []
    var verifiedTransactions: Set<StoreKit.Transaction> = []
    
    private(set) var state: State = .loading
    
    func onUpdatedEntitlements(_ entitlement: StoreKit.Transaction.Transactions.Element) {
        switch entitlement {
        case .verified(let transaction):
            verifiedTransactions.insert(transaction)
        case .unverified(_, let error):
            self.error = error
        }
        updateState()
    }
    
    func retrieveProducts() async {
        do {
            availableProducts = try await Product.products(
                for: subscriptionProductIDs + [lifetimeProductID]
            )
        } catch {
            self.error = error
        }
        updateState()
    }
    
    private func updateState() {
        let verifiedProductID = verifiedTransactions.first?.productID
        if let verifiedProductID, let product = availableProducts.first(where: { $0.id == verifiedProductID }) {
            self.state = .purchased(product)
            return
        }
        
        if let _ = error {
            self.state = .unavailable
            return
        }
        
        if !availableProducts.isEmpty {
            self.state = .purchasable(availableProducts)
            return
        }
    }
}

struct PaywallHostingView: View {
    @State
    var viewModel: PaywallHostingViewModel = .init()
    
    var body: some View {
        content
            .task {
                for await entitlement in Transaction.currentEntitlements {
                    viewModel.onUpdatedEntitlements(entitlement)
                }
            }
            .task {
                await viewModel.retrieveProducts()
            }
    }
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .purchased(let product):
            Text(product.displayName)
        case .purchasable(let products):
            let features: [Feature] = [
                .init(
                    title: "カスタムアイコン",
                    description: "あああ"
                ),
                .init(
                    title: "ポストの投稿",
                    description: "あああああああ"
                ),
                .init(
                    title: "ポストの投稿",
                    description: "あああああああああああああああああああああああああああああああああああああああああああああああああ"
                ),
            ]
            let reviews: [Review] = [
                .init(
                    reviewer: "noppe",
                    rating: 5,
                    comment: "aaaa"
                )
            ]
            let configuration = PaywallViewConfiguration(
                title: "DAWN Pro",
                products: products,
                features: features,
                reviews: reviews,
                privacyPolicyURL: URL(string: "https://www.apple.com/legal/privacy/en-ww/")!,
                termsOfServiceURL: URL(string: "https://www.apple.com/legal/internet-services/terms/site.html")!
            )
            PaywallView(content: {
                TimelineView(.animation) { timeline in
                    let seconds = timeline
                        .date
                        .timeIntervalSinceReferenceDate
                    let angle = Angle.degrees(seconds * 10)
                    RadialLinesView(additionalAngle: angle)
                }.mask {
                    EdgeGradient()
                }
                .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                .frame(maxWidth: 360)
                .overlay {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.white)
                        .overlay {
                            Text("🦊")
                                .font(.title)
                        }
                }
            }, configuration)
        case .unavailable:
            Text("Unavailable")
        }
    }
}
