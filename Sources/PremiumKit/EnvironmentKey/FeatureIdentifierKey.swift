import SwiftUI
import UIKit

private struct FeatureIdentifierKey: EnvironmentKey {
    static var defaultValue: String { "" }
}

public struct FeatureIdentifierTrait: UITraitDefinition {
    public static var defaultValue: String { "" }
}

extension FeatureIdentifierKey: UITraitBridgedEnvironmentKey {
    public static func read(from traitCollection: UITraitCollection) -> String {
        traitCollection.featureIdentifier
    }
    
    public static func write(to mutableTraits: inout any UIMutableTraits, value: String) {
        mutableTraits.featureIdentifier = value
    }
}

extension EnvironmentValues {
    public var featureIdentifier: String {
        get { self[FeatureIdentifierKey.self] }
        set { self[FeatureIdentifierKey.self] = newValue }
    }
}

extension UITraitCollection {
    public var featureIdentifier: String {
        get { self[FeatureIdentifierTrait.self] }
    }
}

extension UIMutableTraits {
    public var featureIdentifier: String {
        get { self[FeatureIdentifierTrait.self] }
        set { self[FeatureIdentifierTrait.self] = newValue }
    }
}

extension View {
    public func featureIdentifier(_ identifier: String) -> some View {
        environment(\.featureIdentifier, identifier)
    }
}
