
import SwiftUI

struct SaraQuiz3: View {
    var body: some View {
        BaseQuizView(
            correctAnswer1: "Option_Comfort",
            correctAnswer2: true,
            backgroundImage: "GirlQuiz",
            celebrationView: { GirlCelebration() },
            tryAgainView: { TryAgain() },
            quizTitleKey: "quiz_titles",
            question1TitleKey: "SadGirlQuestion",
            optionLeftKey: "Option_Ignore",
            optionRightKey: "Option_Comfort",
            answerExplainsKey: "SadGirlQuestion2",
            trueButtonKey: "true_btn",
            falseButtonKey: "false_btn"
        )
    }
}

// MARK: - Preview
#Preview {
    SaraQuiz3()
}
