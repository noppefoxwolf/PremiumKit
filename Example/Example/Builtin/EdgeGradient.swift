import SwiftUI

struct EdgeGradient: View {
    let cornerRadius: CGFloat = 24
    let insets: CGFloat = 16
    
    var body: some View {
        Color.black
            .mask {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .padding(insets)
                    .blur(radius: insets / 2)
            }
    }
}
