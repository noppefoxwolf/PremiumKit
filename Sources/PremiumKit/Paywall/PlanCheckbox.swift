import SwiftUI
import StoreKit

struct PlanCheckbox: View {
    @Binding
    var selectedPlan: StoreKit.Product
    
    let plan: StoreKit.Product
    
    var isSelected: Bool { plan == selectedPlan }
    
    var body: some View {
        Button {
            selectedPlan = plan
        } label: {
            HStack {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.accentColor)
                } else {
                    Image(systemName: "circle")
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text(plan.displayName)
                    Text(plan.displayPrice).bold()
                }.foregroundStyle(.black)
                
                Spacer()
            }
            .frame(minHeight: 44)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.white)
        .mask(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(style: .init(lineWidth: 1))
                .foregroundStyle(.separator)
        }
    }
}
