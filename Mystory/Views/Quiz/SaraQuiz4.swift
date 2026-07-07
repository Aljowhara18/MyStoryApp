
import SwiftUI

struct SaraQuiz4: View {
    var body: some View {
        BaseQuizView(
            correctAnswer1: "Option_Breathe",
            correctAnswer2: true,
            backgroundImage: "GirlQuiz",
            celebrationView: { GirlCelebration() },
            tryAgainView: { TryAgain() },
            quizTitleKey: "quiz_titles",
            question1TitleKey: "AngryGirlQuestion",
            optionLeftKey: "Option_Throw",
            optionRightKey: "Option_Breathe",
            answerExplainsKey: "AngryGirlQuestion2",
            trueButtonKey: "true_btn",
            falseButtonKey: "false_btn"
        )
    }
}

// MARK: - Preview
#Preview {
    SaraQuiz4()
}
