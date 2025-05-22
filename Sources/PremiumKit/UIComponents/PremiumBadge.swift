import SwiftUI

struct PremiumBadge: View {
    var body: some View {
        Text("Premium")
            .font(.caption)
            .textCase(.uppercase)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background {
                RoundedRectangle(
                    cornerRadius: 6
                ).stroke()
            }
    }
}
