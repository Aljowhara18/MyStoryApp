import SwiftUI

struct Splash: View {
    @State private var shouldNavigateToSelectChar = false

    @State private var showStars = false
    @State private var showBottomWave = false
    @State private var showCharacters = false
    @State private var showText = false

    let totalDuration: Double = 4.2

    var body: some View {
        if shouldNavigateToSelectChar {
            NavigationStack {
                CharacterSelection()
            }
        } else {
            GeometryReader { geometry in
                ZStack {
                    Color("MainColor")
                        .ignoresSafeArea()

                    VStack {
                        Spacer()
                        WaveShape()
                            .fill(Color("Baige"))
                            .frame(height: geometry.size.height * 0.85)
                            .padding(.bottom, -20)
                            .offset(y: showBottomWave ? 0 : 700)
                    }
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 1.9), value: showBottomWave)

                    ForEach(0..<5, id: \.self) { index in
                        TwinklingStar(
                            size: starSize(index),
                            position: starPosition(index, in: geometry.size),
                            rotation: starRotation(index),
                            show: showStars,
                            delay: Double(index) * 0.5
                        )
                    }

                    ZStack {
                        Image("GreetingB")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 380, height: 380)
                            .position(x: geometry.size.width * 0.75,
                                      y: geometry.size.height * 0.55)
                            .offset(x: showCharacters ? 0 : 400)

                        Image("GreetingG")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 340, height: 340)
                            .position(x: geometry.size.width * 0.25,
                                      y: geometry.size.height * 0.55)
                            .offset(x: showCharacters ? 0 : -400)
                    }
                    .animation(.easeInOut(duration: 1.5), value: showCharacters)

                    VStack(spacing: 4) {
                        Text(NSLocalizedString("splash_welcome1", comment: ""))
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 61/255, green: 48/255, blue: 40/255))

                        Text(NSLocalizedString("splash_welcome2", comment: ""))
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(red: 45/255, green: 36/255, blue: 22/255))
                    }
                    .offset(y: -geometry.size.height * 0.3)
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : -30)
                    .animation(.easeOut(duration: 0.8), value: showText)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showStars = true
                    showBottomWave = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    showCharacters = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
                    showText = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        shouldNavigateToSelectChar = true
                    }
                }
            }
        }
    }

    // MARK: - Star Layout
    func starSize(_ index: Int) -> CGFloat {
        [70, 65, 100, 90, 95][index]
    }

    func starRotation(_ index: Int) -> Double {
        [45, -30, 60, -45, 15][index]
    }

    func starPosition(_ index: Int, in size: CGSize) -> CGPoint {
        let positions: [(CGFloat, CGFloat)] = [
            (0.10, 0.20),
            (0.70, 0.25),
            (0.25, 0.52),
            (0.75, 0.48),
            (0.48, 0.65)
        ]
        return CGPoint(
            x: size.width * positions[index].0,
            y: size.height * positions[index].1
        )
    }
}

// MARK: - Preview
#Preview {
    Splash()
}
