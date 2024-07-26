// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

#Preview(body: {
    NavigationView {
        List {
            NavigationLink {
                
            } label: {
                Text("Hello, World!")
            }
            
            Button {
                print("1")
            } label: {
                Text("Hello, World!")
            }
            ._onButtonGesture(
                pressing: nil,
                perform: {
                    print("2")
                }
            )   
        }
    }
})



