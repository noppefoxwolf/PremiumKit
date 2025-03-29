import Foundation
import StoreKit

public struct Feature: Identifiable, Sendable, Equatable {
    public let id: String
    public let title: String
    public let description: String
    
    public init(
        id: String = UUID().uuidString,
        title: String,
        description: String
    ) {
        self.id = id
        self.title = title
        self.description = description
    }
}

public struct Review: Identifiable, Sendable, Equatable {
    public let id: String
    public let reviewer: String
    public let rating: Int
    public let comment: String
    
    public init(id: String = UUID().uuidString, reviewer: String, rating: Int, comment: String) {
        self.id = id
        self.reviewer = reviewer
        self.rating = rating
        self.comment = comment
    }
}

public struct PaywallViewConfiguration: Equatable, Sendable {
    public let title: String
    public let subtitle: String = "Phone、iPad、およびMac上のすべてのツールにアクセス"
    public let products: [StoreKit.Product]
    public let features: [Feature]
    public let reviews: [Review]
    public let privacyPolicyURL: URL
    public let termsOfServiceURL: URL
    
    public init(
        title: String,
        products: [StoreKit.Product],
        features: [Feature],
        reviews: [Review],
        privacyPolicyURL: URL,
        termsOfServiceURL: URL
    ) {
        self.title = title
        self.products = products
        self.features = features
        self.reviews = reviews
        self.privacyPolicyURL = privacyPolicyURL
        self.termsOfServiceURL = termsOfServiceURL
    }
}
