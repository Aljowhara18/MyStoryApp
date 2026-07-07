import SwiftUI

struct CelebrationView: View {
    // MARK: - Animation State
    @State private var boyOpacity: Double = 0
    @State private var boyScale: CGFloat = 0.6
    @State private var boyOffsetY: CGFloat = 60

    @State private var confettiOpacity: Double = 0
    @State private var leftConfettiScale: CGFloat = 0.6
    @State private var rightConfettiScale: CGFloat = 0.6

    @State private var confettiFloat: CGFloat = 0
    @State private var confettiWiggle: CGFloat = 0

    @State private var titleScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0

    @State private var fadeOut: Double = 0
    @State private var goHome: Bool = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.screenBackground.ignoresSafeArea()

                VStack {
                    Text("احسنت")
                        .font(.system(size: 36, weight: .regular))
                        .foregroundColor(.black)
                        .scaleEffect(titleScale)
                        .opacity(titleOpacity)
                        .padding(.top, 90)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: titleScale)
                        .animation(.easeOut(duration: 0.3), value: titleOpacity)

                    Spacer()

                    HStack {
                        Image("RightConfetti")
                            .scaleEffect(leftConfettiScale)
                            .opacity(confettiOpacity)
                            .rotationEffect(.degrees(Double(confettiWiggle)))
                            .offset(x: -4 * confettiWiggleSign, y: -confettiFloat)
                            .padding(.horizontal,65)
                            .padding(.top,200)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: leftConfettiScale)
                            .animation(.easeOut(duration: 0.4), value: confettiOpacity)

                        Image("LeftConfetti")
                            .scaleEffect(rightConfettiScale)
                            .opacity(confettiOpacity)
                            .rotationEffect(.degrees(-Double(confettiWiggle)))
                            .offset(x: 4 * confettiWiggleSign, y: -confettiFloat)
                            .padding(.horizontal,66)
                            .padding(.top, 200)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: rightConfettiScale)
                            .animation(.easeOut(duration: 0.4), value: confettiOpacity)
                    }

                    Image("CelebrateBoy")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 320)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom,0)
                        .opacity(boyOpacity)
                        .scaleEffect(boyScale)
                        .offset(y: boyOffsetY)
                        .animation(.spring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.1), value: boyScale)
                        .animation(.spring(response: 0.7, dampingFraction: 0.75, blendDuration: 0.1), value: boyOffsetY)
                        .animation(.easeOut(duration: 0.3), value: boyOpacity)
                }
                .ignoresSafeArea()

                Color.screenBackground
                    .ignoresSafeArea()
                    .opacity(fadeOut)
                    .animation(.easeInOut(duration: 0.6), value: fadeOut)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    titleOpacity = 1
                    titleScale = 1.05
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        titleScale = 1.0
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    confettiOpacity = 1
                    leftConfettiScale = 1.05
                    rightConfettiScale = 1.05
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        leftConfettiScale = 1.0
                        rightConfettiScale = 1.0
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    boyOpacity = 1
                    boyScale = 1.08
                    boyOffsetY = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        boyScale = 1.0
                    }
                }

                startConfettiLoop()

                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    fadeOut = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                        goHome = true
                    }
                }
            }
            .onDisappear {
                stopConfettiLoop()
            }
            .navigationDestination(isPresented: $goHome) {
                HomeView(character: .boy)
            }
        }
    }

    // MARK: - Confetti Animation
    private var confettiWiggleSign: CGFloat {
        confettiWiggle == 0 ? 0 : (confettiWiggle > 0 ? 1 : -1)
    }

    private func startConfettiLoop() {
        withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
            confettiFloat = 8
        }
        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            confettiWiggle = 6
        }
    }

    private func stopConfettiLoop() {
        confettiFloat = 0
        confettiWiggle = 0
    }
}

#Preview {
    CelebrationView()
}
