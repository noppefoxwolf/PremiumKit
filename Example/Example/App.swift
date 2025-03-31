import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            PurchaseSuccessView()
        }
    }
}
import SwiftUI

struct PurchaseSuccessView: View {
    var body: some View {
        List {
            Section {
                Text("aaa")
            } header: {
                HStack {
                    VStack(alignment: .leading) {
                        Text("DAWN Pro")
                            .font(.headline)
                        Text("noppefoxwolf")
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("aaa")
                }
            }
            
        }
    }
}

#Preview {
    ZStack {
        CircularTextView(
            title: "サブスクリプション"
        )
        CircularTextView(
            title: "エディション",
            offsetAngle: .degrees(180)
        )
    }
    
    .fontWeight(.black)
    .frame(width: 120, height: 120)
    .overlay {
        Text("🦊")
    }
}


import SwiftUI

struct CircularTextView: View {
    @State var title: String
    var angle: Angle = .degrees(180)
    var offsetAngle: Angle = .degrees(0)
    
    init(
        title: String,
        angle: Angle = .degrees(180),
        offsetAngle: Angle = .degrees(0)
    ) {
        self.title = title
        self.angle = angle
        self.offsetAngle = offsetAngle
    }
    
    var lettersOffset: [(offset: Int, element: Character)] {
        Array(title.enumerated())
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            ForEach(lettersOffset, id: \.offset) { index, letter in
                Text(String(letter))
                    .frame(maxHeight: .infinity, alignment: .top)
                    .rotationEffect(fetchAngle(at: index))
            }
            .rotationEffect(offsetAngle)
        }
    }
    
    func fetchAngle(at index: Int) -> Angle {
        let count = title.count
        guard count > 0 else { return .zero }
        
        let anglePerLetter = angle.radians / Double(count)
        let offsetFromCenter = Double(index) - Double(count - 1) / 2.0
        let angleForIndex = anglePerLetter * offsetFromCenter
        
        return .radians(angleForIndex)
    }
}



struct WidthLetterPreferenceKey: PreferenceKey {
    static var defaultValue: Double = 0
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct LetterWidthSize: View {
    var body: some View {
        GeometryReader { geometry in // using this to get the width of EACH letter
            Color
                .clear
                .preference(key: WidthLetterPreferenceKey.self,
                            value: geometry.size.width)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularTextView(title: "Let's learn SwiftUI! The most magical Framework!".uppercased(), radius: 125)
//    }
//}
