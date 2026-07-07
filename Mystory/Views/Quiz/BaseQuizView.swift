
import SwiftUI

// MARK: - القالب العام لكل الكويزات
struct BaseQuizView<Celebration: View, TryAgain: View>: View {

    @State private var selectedOption1: String? = nil
    @State private var selectedOption2: Bool? = nil
    @State private var quizCompleted: Bool = false
    @State private var navigateToCelebration: Bool = false
    @State private var navigateToTryAgain: Bool = false

    let correctAnswer1: String
    let correctAnswer2: Bool
    let backgroundImage: String
    let celebrationView: () -> Celebration
    let tryAgainView: () -> TryAgain

    let quizTitleKey: String
    let question1TitleKey: String
    let optionLeftKey: String
    let optionRightKey: String
    let answerExplainsKey: String
    let trueButtonKey: String
    let falseButtonKey: String

    let selectedColor = Color.gray.opacity(0.3)
    let defaultColor = Color.white.opacity(0.8)
    let correctColor = Color.green.opacity(0.5)
    let wrongColor = Color.red.opacity(0.5)

    // MARK: - Logic
    func checkAnswers() {
        quizCompleted = true
        let allCorrect = selectedOption1 == correctAnswer1 && selectedOption2 == correctAnswer2
        if allCorrect {
            navigateToCelebration = true
        } else {
            navigateToTryAgain = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                navigateToTryAgain = false
                resetQuiz()
            }
        }
    }

    func resetQuiz() {
        selectedOption1 = nil
        selectedOption2 = nil
        quizCompleted = false
    }

    func getOption1Color(optionValue: String) -> Color {
        let selected = selectedOption1 == optionValue
        guard quizCompleted else { return selected ? selectedColor : defaultColor }
        return selected ? (optionValue == correctAnswer1 ? correctColor : wrongColor) : defaultColor
    }

    func getOption2Color(optionValue: Bool) -> Color {
        let selected = selectedOption2 == optionValue
        guard quizCompleted else { return selected ? selectedColor : defaultColor }
        return selected ? (optionValue == correctAnswer2 ? correctColor : wrongColor) : defaultColor
    }

    // MARK: - UI
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
            ZStack {
                Image(backgroundImage)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)

                VStack {
                    Text(NSLocalizedString(quizTitleKey, comment: ""))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, geo.size.height * 0.42)

                    Spacer().frame(height: 20)

                    VStack(alignment: .leading, spacing: 16) {

                        Text(NSLocalizedString(question1TitleKey, comment: ""))
                            .font(.headline)
                            .foregroundColor(.black)

                        HStack(spacing: 20) {
                            Button(action: {
                                if !quizCompleted { selectedOption1 = optionLeftKey }
                            }) {
                                Text(NSLocalizedString(optionLeftKey, comment: ""))
                                    .frame(width: 157, height: 34)
                                    .background(getOption1Color(optionValue: optionLeftKey))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                if !quizCompleted { selectedOption1 = optionRightKey }
                            }) {
                                Text(NSLocalizedString(optionRightKey, comment: ""))
                                    .frame(width: 157, height: 34)
                                    .background(getOption1Color(optionValue: optionRightKey))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                        }

                        Text(NSLocalizedString(answerExplainsKey, comment: ""))
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 32)

                        HStack(spacing: 16) {
                            Button(action: {
                                if !quizCompleted { selectedOption2 = true }
                            }) {
                                Text(NSLocalizedString(trueButtonKey, comment: ""))
                                    .frame(width: 71, height: 34)
                                    .background(getOption2Color(optionValue: true))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                if !quizCompleted { selectedOption2 = false }
                            }) {
                                Text(NSLocalizedString(falseButtonKey, comment: ""))
                                    .frame(width: 71, height: 34)
                                    .background(getOption2Color(optionValue: false))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                        }

                        Spacer().frame(height: 50)

                        Button(action: {
                            quizCompleted ? resetQuiz() : checkAnswers()
                        }) {
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
                        .shadow(color: Color.cardShadow.opacity(0.5), radius: 5, x: 0, y: 5)
                        .padding(.bottom, 64)
                        .frame(maxWidth: .infinity)
                        .accessibilityLabel(quizCompleted ? NSLocalizedString("retry_quiz", comment: "") : NSLocalizedString("next_btn", comment: ""))
                    }
                    .padding(.horizontal)
                }
            }
            }
            .navigationDestination(isPresented: $navigateToCelebration) {
                celebrationView()
            }
            .navigationDestination(isPresented: $navigateToTryAgain) {
                tryAgainView()
            }
        }
    }
}
