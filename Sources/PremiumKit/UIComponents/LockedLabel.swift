import SwiftUI

struct LockedLabel<Label: View>: View {
    let label: () -> Label
    
    var body: some View {
        LabeledContent(
            content: {
                Image(systemName: "lock.fill")
            },
            label: {
                label()
            }
        )
    }
}
