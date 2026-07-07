//
//  CharacterSelection.swift
//  Mystory
//

import SwiftUI

struct CharacterSelection: View {
    enum Selection {
        case boy, girl, none
    }

    @State private var selection: Selection = .none
    @State private var navigateToHome: Bool = false

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.screenBackground
                .ignoresSafeArea()

            GeometryReader { geo in
                let width = geo.size.width
                let avatarSize = width * 0.32
                let horizontalSpacing = width * 0.07
                let topTitlePadding: CGFloat = 88
                let rowTopPadding: CGFloat = geo.size.height * 0.25

                VStack(spacing: 0) {

                    Text(NSLocalizedString("choose_character_title", comment: ""))
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.primary)
                        .padding(.top, topTitlePadding)

                    Spacer(minLength: rowTopPadding)

                    HStack(spacing: horizontalSpacing) {

                        avatarButton(
                            imageName: "boy",
                            isSelected: selection == .boy,
                            isAnySelected: selection != .none,
                            baseSize: avatarSize
                        ) {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                selection = .boy
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                navigateToHome = true
                            }
                        }
                        .accessibilityLabel(NSLocalizedString("choose_boy", comment: ""))

                        avatarButton(
                            imageName: "girl",
                            isSelected: selection == .girl,
                            isAnySelected: selection != .none,
                            baseSize: avatarSize
                        ) {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                selection = .girl
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                navigateToHome = true
                            }
                        }
                        .accessibilityLabel(NSLocalizedString("choose_girl", comment: ""))
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationDestination(isPresented: $navigateToHome) {

            // ✨ بناءً على الاختيارِ، يوديك للشخصية الصحيحة
            if selection == .boy {
                HomeView(character: .boy)
            } else {
                HomeView(character: .girl)
            }
        }
        .onAppear {
            // ترجع الأفاتار لحجمها الطبيعي لو المستخدم رجع لهذي الشاشة
            selection = .none
        }
    }

    // MARK: - Avatar Button
    // زر الشخصيات مع التأثيرات
    @ViewBuilder
    private func avatarButton(imageName: String,
                              isSelected: Bool,
                              isAnySelected: Bool,
                              baseSize: CGFloat,
                              action: @escaping () -> Void) -> some View {

        let shouldDim = isAnySelected && !isSelected
        let scale: CGFloat = isSelected ? 1.18 : (shouldDim ? 0.82 : 1.0)
        let opacity: Double = shouldDim ? 0.35 : 1.0
        let shadowRadius: CGFloat = isSelected ? 8 : 0

        Button(action: action) {
            ZStack {
                if isSelected {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: baseSize, height: baseSize)
                        .blur(radius: 3)
                        .shadow(color: .white.opacity(0.9), radius: 10, x: 0, y: 0)
                        .opacity(0.9)
                }

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: baseSize, height: baseSize)
                    .overlay(
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: baseSize, height: baseSize)
                            .colorMultiply(.white)
                            .blur(radius: isSelected ? 0.8 : 0)
                            .opacity(isSelected ? 1 : 0)
                    )
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .shadow(
                color: Color.black.opacity(isSelected ? 0.15 : 0),
                radius: shadowRadius,
                x: 0, y: 6
            )
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isSelected)
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isAnySelected)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        CharacterSelection()
    }
}
