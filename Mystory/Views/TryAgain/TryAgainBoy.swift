//
//  TryAgainBoy.swift
//  Mystory
//
//  Created by Teif May on 24/06/1447 AH.
//

import SwiftUI

struct TryAgainBoy: View {
    @Environment(\.dismiss) private var dismiss

    @State private var boyOpacity: Double = 0
    @State private var boyScale: CGFloat = 0.1
    @State private var boyOffsetY: CGFloat = 40

    @State private var titleScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0

    var body: some View {
        ZStack {
            Color.screenBackground.ignoresSafeArea()

            VStack {

                // زر الرجوع داخل دائرة
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 21, weight: .medium))
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(180))      // يخلي السهم يمين
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.7)) // الخلفية الفاتحة
                                    .shadow(
                                        color: Color.black.opacity(0.19),
                                        radius: 6, x: 0, y: 3
                                    )
                            )
                    }
                    .accessibilityLabel(NSLocalizedString("back_button", comment: ""))
                    .padding(.leading, 20)
                    .padding(.top, 12)

                    Spacer()
                }

                // النص
                Text("حاول مره أخرى")
                    .font(.system(size: 36, weight: .regular))
                    .foregroundColor(.black)
                    .scaleEffect(titleScale)
                    .opacity(titleOpacity)
                    .padding(.top, -10)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: titleScale)
                    .animation(.easeOut(duration: 0.3), value: titleOpacity)

                Spacer()

                // صورة الولد
                Image("TryAgainBoy")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 266)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 0)
                    .opacity(boyOpacity)
                    .scaleEffect(boyScale)
                    .offset(y: boyOffsetY + 40)
                    .animation(.spring(response: 0.6, dampingFraction: 0.65), value: boyScale)
                    .animation(.spring(response: 0.7, dampingFraction: 0.75), value: boyOffsetY)
                    .animation(.easeOut(duration: 0.3), value: boyOpacity)

                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                titleOpacity = 1
                titleScale = 1.05
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    titleScale = 1.0
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
        }
    }
}

#Preview {
    TryAgainBoy()
}
