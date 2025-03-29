import SwiftUI
import StoreKit
import os

struct PaywallViewError: LocalizedError {
    var errorDescription: String?
    
    init<E: Error>(_ error: E) {
        self.errorDescription = error.localizedDescription
    }
}

@Observable
final class PaywallViewModel {
    let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: #file
    )
    let configuration: PaywallViewConfiguration
    var selectedProduct: StoreKit.Product
    var isExpanded = false
    var error: PaywallViewError? = nil
    var isErrorPresented: Bool {
        get { error != nil }
        set { error = nil }
    }
    
    init(configuration: PaywallViewConfiguration) {
        self.configuration = configuration
        self.selectedProduct = configuration.products.first(where: { $0.type != .nonConsumable })!
    }
    
    func onTapExpandButton() {
        isExpanded = true
    }
    
    func onTapReduceButton() {
        if selectedProduct.type == .nonConsumable {
            selectedProduct = configuration.products.first(where: { $0.type != .nonConsumable })!
        }
        isExpanded = false
    }
    
    func onTapPurchase() async {
        logger.info("\(#function) \(self.selectedProduct.displayName)")
        do {
            try await selectedProduct.purchase()
        } catch {
            logger.error("\(error)")
            self.error = PaywallViewError(error)
        }
    }
    
    func onTapRestore() async {
        logger.info(#function)
        do {
            try await AppStore.sync()
        } catch {
            logger.error("\(error)")
            self.error = PaywallViewError(error)
        }
    }
}

// SubscriptionView, StoreView
public struct PaywallView<Content: View>: View {
    @State
    var viewModel: PaywallViewModel
    
    @ViewBuilder
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content, _ configuration: PaywallViewConfiguration) {
        self.content = content
        self.viewModel = .init(configuration: configuration)
    }
    
    public var body: some View {
        ScrollView(
            content: {
                LazyVStack(spacing: 16) {
                    content()
                    
                    Text(viewModel.configuration.subtitle)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    ForEach(viewModel.configuration.features) { feature in
                        FeatureLabel(feature: feature)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider()

            }
            .padding()
        })
        .navigationTitle(viewModel.configuration.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    
                } label: {
                    Label("Cancel", systemImage: "xmark")
                }
                .labelStyle(.iconOnly)
            }
        })
        .safeAreaInset(edge: .bottom) {
            VStack {
                ForEach(viewModel.configuration.products.filter { $0.type != .nonConsumable }) { plan in
                    PlanCheckbox(selectedPlan: $viewModel.selectedProduct, plan: plan)
                }
                
                if viewModel.isExpanded {
                    ForEach(viewModel.configuration.products.filter { $0.type == .nonConsumable }) { plan in
                        PlanCheckbox(selectedPlan: $viewModel.selectedProduct, plan: plan)
                    }
                    
                    Button {
                        viewModel.onTapReduceButton()
                    } label: {
                        Text("標準プランを表示")
                            .font(.caption)
                    }
                } else {
                    Button {
                        viewModel.onTapExpandButton()
                    } label: {
                        Text("すべてのプランを表示")
                            .font(.caption)
                    }
                }
                
                purchaseButton()
                
                footer()
            }
            .padding()
            .background(Material.regular)
        }
        .animation(.default, value: viewModel.isExpanded)
        .alert(isPresented: $viewModel.isErrorPresented, error: viewModel.error) {
            Button {
                
            } label: {
                Text("OK")
            }

        }
    }
    
    func purchaseButton() -> some View {
        Button {
            Task { [viewModel] in
                await viewModel.onTapPurchase()
            }
        } label: {
            Text("Get Pro")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .controlSize(.extraLarge)
        .buttonStyle(.borderedProminent)
    }
    
    func footer() -> some View {
        HStack {
            Link(destination: viewModel.configuration.privacyPolicyURL) {
                Text("Privacy Policy")
            }
            
            Text("|")
            
            Link(destination: viewModel.configuration.termsOfServiceURL) {
                Text("Terms of Use")
            }
            
            Text("|")
            
            Button {
                Task { [viewModel] in
                    await viewModel.onTapRestore()
                }
            } label: {
                Text("Restore Purchase")
            }
        }
        .font(.footnote)
        .foregroundStyle(.tertiary)
    }
}

