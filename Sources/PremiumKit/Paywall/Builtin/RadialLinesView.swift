import SwiftUI

struct RadialLinesView: View {
    let lineCount: Int = 28
    let additionalAngle: Angle
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            
            for i in 0..<lineCount {
                
                let angle = Angle(degrees: Double(i) * (360.0 / Double(lineCount))) + additionalAngle
                let dx = cos(angle.radians)
                let dy = sin(angle.radians)
                
                let scaleX = dx != 0 ? (dx > 0 ? (size.width - center.x) / dx : -center.x / dx) : .infinity
                let scaleY = dy != 0 ? (dy > 0 ? (size.height - center.y) / dy : -center.y / dy) : .infinity
                
                let scale = min(scaleX, scaleY)
                
                let x = center.x + CGFloat(dx) * scale
                let y = center.y + CGFloat(dy) * scale
                
                var path = Path()
                path.move(to: center)
                path.addLine(to: CGPoint(x: x, y: y))
                context.stroke(path, with: .color(.black), lineWidth: 1)
            }
        }
    }
}
