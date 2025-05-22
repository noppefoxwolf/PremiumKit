import SwiftUI

struct PremiumLabel<Label: View>: View {
    @Environment(\.isPremium)
    var isPremium
    
    @Environment(\.isLockable)
    var isLockable
    
    let label: () -> Label
    
    var body: some View {
        switch (isLockable, isPremium) {
        case (true, false):
            LockedLabel(label: label)
        case (false, false):
            LabeledContent(
                content: {
                    PremiumBadge()
                },
                label: {
                    label()
                }
            )
        default:
            label()
        }
    }
}

