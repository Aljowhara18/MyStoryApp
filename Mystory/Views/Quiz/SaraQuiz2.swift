
import SwiftUI

struct SaraQuiz2: View {
    var body: some View {
        BaseQuizView(
            correctAnswer1: "Option_Calm",
            correctAnswer2: true,
            backgroundImage: "GirlQuiz",
            celebrationView: { GirlCelebration() },
            tryAgainView: { TryAgain() },
            quizTitleKey: "quiz_titles",
            question1TitleKey: "ShyGirlQuestion",
            optionLeftKey: "Option_Hide",
            optionRightKey: "Option_Calm",
            answerExplainsKey: "ShyGirlQuestion2",
            trueButtonKey: "true_btn",
            falseButtonKey: "false_btn"
        )
    }
}

// MARK: - Preview
#Preview {
    SaraQuiz2()
}
