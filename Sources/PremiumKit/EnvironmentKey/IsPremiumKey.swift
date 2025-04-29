import SwiftUI
import UIKit

private struct IsPremiumKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public struct IsPremiumTrait: UITraitDefinition {
    public static let defaultValue: Bool = false
}

extension IsPremiumKey: UITraitBridgedEnvironmentKey {
    public static func read(from traitCollection: UITraitCollection) -> Bool {
        traitCollection.isPremium
    }
    
    public static func write(to mutableTraits: inout any UIMutableTraits, value: Bool) {
        mutableTraits.isPremium = value
    }
}

extension EnvironmentValues {
    public var isPremium: Bool {
        get { self[IsPremiumKey.self] }
        set { self[IsPremiumKey.self] = newValue }
    }
}

extension UITraitCollection {
    public var isPremium: Bool {
        get { self[IsPremiumTrait.self] }
    }
}

extension UIMutableTraits {
    public var isPremium: Bool {
        get { self[IsPremiumTrait.self] }
        set { self[IsPremiumTrait.self] = newValue }
    }
}
