import SwiftUI
import PremiumKit

struct ContentView: View {
    @State
    var isPremium: Bool = true
    
    @State
    var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                PremiumNavigationLink {
                    EmptyView()
                } label: {
                    Text("Hello, World!")
                }
                
                PremiumNavigationLink {
                    EmptyView()
                } label: {
                    Text("Hello, World!")
                }.lockable()
                
                PremiumButton(
                    action: {
                        isPresented.toggle()
                    },
                    label: {
                        Text("App Icon")
                    }
                )
                
                PremiumButton(
                    action: {
                        isPresented.toggle()
                    },
                    label: {
                        Text("App Icon")
                    }
                ).lockable()
                
                Toggle(isOn: $isPremium) {
                    Text("isPremium")
                }
            }
        }
        .sheet(isPresented: $isPresented, content: {
            ChildView()
        })
        .environment(\.isPremium, isPremium)
    }
}

struct ChildView: View {
    
    @State
    var isPremium: Bool = true
    
    var body: some View {
        VStack {
            PremiumButton(
                action: {
                    print("changed!")
                },
                label: {
                    Text("App Icon")
                }
            )
            Toggle(isOn: $isPremium) {
                Text("isPremium")
            }
        }
        .environment(\.isPremium, isPremium)
    }
}

