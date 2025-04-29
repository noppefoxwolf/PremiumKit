import SwiftUI
import UIKit

private struct IsLockableKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public struct IsLockableTrait: UITraitDefinition {
    public static let defaultValue: Bool = false
}

extension IsLockableKey: UITraitBridgedEnvironmentKey {
    public static func read(from traitCollection: UITraitCollection) -> Bool {
        traitCollection.isLockable
    }
    
    public static func write(to mutableTraits: inout any UIMutableTraits, value: Bool) {
        mutableTraits.isLockable = value
    }
}

extension EnvironmentValues {
    public var isLockable: Bool {
        get { self[IsLockableKey.self] }
        set { self[IsLockableKey.self] = newValue }
    }
}

extension UITraitCollection {
    public var isLockable: Bool {
        get { self[IsLockableTrait.self] }
    }
}

extension UIMutableTraits {
    public var isLockable: Bool {
        get { self[IsLockableTrait.self] }
        set { self[IsLockableTrait.self] = newValue }
    }
}
