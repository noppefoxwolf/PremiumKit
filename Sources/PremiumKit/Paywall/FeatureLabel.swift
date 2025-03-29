import SwiftUI

struct FeatureLabel: View {
    let feature: Feature
    
    var body: some View {
        HStack(alignment: .title) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .bold()
                .font(.headline)
                .alignmentGuide(
                    .title,
                    computeValue: {
                        $0[VerticalAlignment.center]
                    })
            
            VStack(alignment: .leading) {
                Text(feature.title)
                    .bold()
                    .font(.headline)
                    .alignmentGuide(
                        .title,
                        computeValue: {
                            $0[VerticalAlignment.center]
                        })
                
                Text(feature.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

extension VerticalAlignment {
    private enum TitleAlignment : AlignmentID {
        static func defaultValue(
            in d: ViewDimensions
        ) -> CGFloat {
            d[VerticalAlignment.top]
        }
    }
    static let title = VerticalAlignment(TitleAlignment.self)
}
