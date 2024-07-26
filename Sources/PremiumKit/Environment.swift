import SwiftUI

private struct IsPremiumKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
extension EnvironmentValues {
    public var isPremium: Bool {
        get { self[IsPremiumKey.self] }
        set { self[IsPremiumKey.self] = newValue }
    }
}

private struct IsLockableKey: EnvironmentKey {
    static let defaultValue: Bool = false
}
extension EnvironmentValues {
    public var isLockable: Bool {
        get { self[IsLockableKey.self] }
        set { self[IsLockableKey.self] = newValue }
    }
}

extension View {
    public func lockable(_ isLockable: Bool = true) -> some View {
        environment(\.isLockable, isLockable)
    }
}
