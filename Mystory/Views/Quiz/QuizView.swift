//
//  Quiz.swift
//  Mystory
//
//  Created by Jojo on 04/12/2025.
//
import SwiftUI

struct QuizView: View {

    let scenarioIndex: Int   // يجي من صفحة القصة

    // حماية بسيطة لو انطلب رقم أكبر من عدد السيناريوهات
    private var safeIndex: Int {
        guard !quizScenarios.isEmpty else { return 0 }
        return min(max(scenarioIndex, 0), quizScenarios.count - 1)
    }

    var scenario: QuizScenario {
        quizScenarios[safeIndex]
    }

    @State private var selectedOption1: Int? = nil
    @State private var selectedOption2: Bool? = nil
    @State private var quizCompleted = false
    @State private var navigateToCelebration = false
    @State private var showTryAgain = false      // 👈 بدال navigateToTryAgain

    let selectedColor = Color.gray.opacity(0.3)
    let defaultColor  = Color.white.opacity(0.8)
    let correctColor  = Color.green.opacity(0.5)
    let wrongColor    = Color.red.opacity(0.5)

    // MARK: - Logic

    func checkAnswers() {
        quizCompleted = true

        let allCorrect =
        selectedOption1 == scenario.correctOptionIndex &&
        selectedOption2 == scenario.correctTrueFalse

        if allCorrect {
            // لو كل الإجابات صح → نروح للاحتفال
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                navigateToCelebration = true
            }
        } else {
            // لو في إجابة غلط → نفتح صفحة حاول مرة أخرى
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showTryAgain = true
            }
        }
    }

    func resetQuiz() {
        selectedOption1 = nil
        selectedOption2 = nil
        quizCompleted = false
    }

    func option1Color(_ index: Int) -> Color {
        guard quizCompleted else {
            return selectedOption1 == index ? selectedColor : defaultColor
        }

        let isCorrect = (index == scenario.correctOptionIndex)
        let userChoseThis = (selectedOption1 == index)

        // لو الطفل جاوب صح → نظهر الصح بالأخضر
        if selectedOption1 == scenario.correctOptionIndex {
            return isCorrect ? correctColor : defaultColor
        }

        // لو الطفل جاوب غلط → فقط نلوّن خياره بالأحمر
        if userChoseThis {
            return wrongColor
        }

        return defaultColor
    }

    func option2Color(_ value: Bool) -> Color {
        guard quizCompleted else {
            return selectedOption2 == value ? selectedColor : defaultColor
        }

        let isCorrect = (value == scenario.correctTrueFalse)
        let userChoseThis = (selectedOption2 == value)

        // لو الطفل جاوب صح
        if selectedOption2 == scenario.correctTrueFalse {
            return isCorrect ? correctColor : defaultColor
        }

        // لو الطفل جاوب غلط → نلوّن خياره فقط بالأحمر
        if userChoseThis {
            return wrongColor
        }

        return defaultColor
    }

    // MARK: - UI

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
            ZStack {
                Image("BoyQuiz")
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)

                VStack {
                    // Quiz title (localized)
                    Text(NSLocalizedString("quiz_title", comment: ""))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, geo.size.height * 0.42)

                    Spacer().frame(height: 20)

                    VStack(alignment: .leading, spacing: 16) {

                        // QUESTION 1
                        Text(NSLocalizedString(scenario.question1Key, comment: ""))
                            .foregroundColor(.black)

                        Group {
                            if scenario.optionKeys.count == 2 {

                                // حالتين جنب بعض (زي فيقما)
                                HStack(spacing: 20) {
                                    ForEach(scenario.optionKeys.indices, id: \.self) { index in
                                        Button {
                                            if !quizCompleted { selectedOption1 = index }
                                        } label: {
                                            Text(
                                                NSLocalizedString(
                                                    scenario.optionKeys[index],
                                                    comment: ""
                                                )
                                            )
                                            .font(.system(size: 14))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.8)
                                            .frame(width: 157, height: 34)
                                            .background(option1Color(index))
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)

                            } else {

                                // لو مستقبلاً حطيتي ٣ خيارات تكون تحت بعض
                                VStack(spacing: 12) {
                                    ForEach(scenario.optionKeys.indices, id: \.self) { index in
                                        Button {
                                            if !quizCompleted { selectedOption1 = index }
                                        } label: {
                                            Text(
                                                NSLocalizedString(
                                                    scenario.optionKeys[index],
                                                    comment: ""
                                                )
                                            )
                                            .font(.system(size: 14))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.8)
                                            .frame(width: 157, height: 34)
                                            .background(option1Color(index))
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }

                        // QUESTION 2 (True / False)
                        Text(NSLocalizedString(scenario.question2Key, comment: ""))
                            .foregroundColor(.black)

                        HStack(spacing: 16) {
                            Button {
                                if !quizCompleted { selectedOption2 = true }
                            } label: {
                                Text(NSLocalizedString("true_btn", comment: ""))
                                    .frame(width: 71, height: 34)
                                    .background(option2Color(true))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }

                            Button {
                                if !quizCompleted { selectedOption2 = false }
                            } label: {
                                Text(NSLocalizedString("false_btn", comment: ""))
                                    .frame(width: 71, height: 34)
                                    .background(option2Color(false))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                        }

                        Spacer().frame(height: 50)

                        // NEXT / RESET
                        Button {
                            quizCompleted ? resetQuiz() : checkAnswers()
                        } label: {
                            if quizCompleted {
                                Image(systemName: "arrow.triangle.2.circlepath")
                            } else {
                                Text(NSLocalizedString("next_btn", comment: ""))
                            }
                        }
                        .frame(width: 90, height: 34)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(17)
                        .shadow(
                            color: Color.cardShadow.opacity(0.5),
                            radius: 5, x: 0, y: 5
                        )
                        .padding(.bottom, 64)
                        .frame(maxWidth: .infinity)
                        .accessibilityLabel(quizCompleted ? NSLocalizedString("retry_quiz", comment: "") : NSLocalizedString("next_btn", comment: ""))
                    }
                    .padding(.horizontal)
                }
            }
            }
            .navigationDestination(isPresented: $navigateToCelebration) {
                CelebrationView()
            }
            // 👇 شاشة حاول مرة أخرى كـ fullScreenCover
            .fullScreenCover(isPresented: $showTryAgain, onDismiss: {
                // لما تتقفل، نرجّع الكويز للوضع الأول
                resetQuiz()
            }) {
                TryAgainBoy()
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(scenarioIndex: 1)
    }
}
