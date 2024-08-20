import SwiftUI
import PremiumKit

struct ContentView: View {
    @State
    var isPremium: Bool = true
    
    @State
    var isPresented: Bool = false
    
    @State
    var isOn: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    PremiumNavigationLink {
                        EmptyView()
                    } label: {
                        Text("Hello, World!")
                    }
                    
                    PremiumButton(
                        action: {
                            isPresented.toggle()
                        },
                        label: {
                            Text("App Icon")
                        }
                    )
                    
                    PremiumToggle(
                        isOn: $isOn,
                        label: {
                            Text("Show User Info")
                        },
                        storeView: {
                            Text("Store")
                        }
                    )
                }, header: {
                    Text("Lockable = true")
                }).lockable()
                
                Section(content: {
                    PremiumNavigationLink {
                        EmptyView()
                    } label: {
                        Text("Hello, World!")
                    }
                    
                    PremiumButton(
                        action: {
                            isPresented.toggle()
                        },
                        label: {
                            Text("App Icon")
                        }
                    )
                    
                    PremiumToggle(
                        isOn: $isOn,
                        label: {
                            Text("Show User Info")
                        },
                        storeView: {
                            Text("Store")
                        }
                    )
                }, header: {
                    Text("Lockable = false")
                })
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle(isOn: $isPremium) {
                        Text("isPremium")
                    }.toggleStyle(.switch)
                }
            })
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

