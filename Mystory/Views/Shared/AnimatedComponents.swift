
import SwiftUI

// MARK: - Twinkling Star
struct TwinklingStar: View {
    let size: CGFloat
    let position: CGPoint
    let rotation: Double
    let show: Bool
    let delay: Double

    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.8

    var body: some View {
        Image("Stars")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .opacity(opacity)
            .scaleEffect(show ? scale : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.6).delay(delay), value: show)
            .rotationEffect(.degrees(rotation))
            .position(position)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.6) {
                    startTwinkling()
                }
            }
    }

    func startTwinkling() {
        withAnimation(.easeInOut(duration: 1.0 + Double.random(in: 0...0.5)).repeatForever(autoreverses: true)) {
            opacity = 0.3
        }

        withAnimation(.easeInOut(duration: 1.5 + Double.random(in: 0...0.5)).repeatForever(autoreverses: true)) {
            scale = 1.3
        }
    }
}

// MARK: - Wave Shape
struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: 0, y: 0))
        path.addCurve(
            to: CGPoint(x: width, y: 0),
            control1: CGPoint(x: width * 0.25, y: height * 0.3),
            control2: CGPoint(x: width * 0.75, y: -height * 0.1)
        )
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()

        return path
    }
}
