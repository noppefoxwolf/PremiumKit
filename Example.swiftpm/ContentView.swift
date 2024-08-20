import SwiftUI
import PremiumKit

struct ContentView: View {
    @State
    var isPremium: Bool = true
    
    @State
    var isPresented: Bool = false
    
    @State
    var isOn: Bool = false
    
    enum SelectionValue: String, CaseIterable {
        case dog
        case cat
        case fox
        case duck
    }
    
    @State
    var selection: SelectionValue = .fox
    
    @State
    var value: Double = 100
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    components
                }, header: {
                    Text("Lockable = true")
                }).lockable()
                
                Section(content: {
                    components
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
    
    @ViewBuilder
    var components: some View {
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
        
        PremiumPicker(
            selection: $selection,
            content: {
                ForEach(SelectionValue.allCases, id: \.self) { value in
                    Text(value.rawValue).tag(value.rawValue)
                }
            },
            label: {
                Text("Who is favourite animal?")
            },
            storeView: {
                Text("Store")
            }
        )
        
        PremiumSlider(
            value: $value,
            inRange: 0...100,
            step: 10,
            label: {
                Text("Font")
            },
            minimumValueLabel: {
                Image(systemName: "textformat.size.smaller")
            },
            maximumValueLabel: {
                Image(systemName: "textformat.size.larger")
            },
            storeView: {
                Text("Store")
            }
        )
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

