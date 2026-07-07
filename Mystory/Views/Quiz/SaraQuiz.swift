
import SwiftUI

struct SaraQuiz: View {
    var body: some View {
        BaseQuizView(
            correctAnswer1: "option_smiles",
            correctAnswer2: true,
            backgroundImage: "GirlQuiz",
            celebrationView: { GirlCelebration() },
            tryAgainView: { TryAgain() },
            quizTitleKey: "quiz_titles",
            question1TitleKey: "question1_titles",
            optionLeftKey: "option_yells",
            optionRightKey: "option_smiles",
            answerExplainsKey: "answer_explains",
            trueButtonKey: "true_btn",
            falseButtonKey: "false_btn"
        )
    }
}

// MARK: - Preview
#Preview {
    SaraQuiz()
}
