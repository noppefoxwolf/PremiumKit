import SwiftUI

public struct PremiumSlider<Value: BinaryFloatingPoint, ValueLabel: View, Label: View, StoreView: View>: View where Value.Stride: BinaryFloatingPoint {
    @Environment(\.isPremium)
    var isPremium
    
    @State
    var isPresented: Bool = false
    
    @Binding
    var value: Value
    
    let inRange: ClosedRange<Value>
    
    let step: Value.Stride
    
    @ViewBuilder
    let label: () -> Label
    
    @ViewBuilder
    let minimumValueLabel: () -> ValueLabel
    
    @ViewBuilder
    let maximumValueLabel: () -> ValueLabel
    
    @ViewBuilder
    let storeView: () -> StoreView
    
    public init(
        value: Binding<Value>,
        inRange: ClosedRange<Value>,
        step: Value.Stride,
        label: @escaping () -> Label,
        minimumValueLabel: @escaping () -> ValueLabel,
        maximumValueLabel: @escaping () -> ValueLabel,
        storeView: @escaping () -> StoreView) {
        self._value = value
        self.inRange = inRange
        self.step = step
        self.label = label
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.storeView = storeView
    }
    
    public var body: some View {
        if isPremium {
            Slider(
                value: _value,
                in: inRange,
                step: step,
                label: label,
                minimumValueLabel: minimumValueLabel,
                maximumValueLabel: maximumValueLabel
            )
        } else {
            Button(action: {
                isPresented.toggle()
            }, label: {
                LockedLabel(label: label)
            })
            .sheet(isPresented: $isPresented) {
                storeView()
            }
        }
    }
}
