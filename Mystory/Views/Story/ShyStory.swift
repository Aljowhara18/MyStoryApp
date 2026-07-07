
import SwiftUI

struct ShyStory: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "shy_title", textKey: "shy_text_1", imageName: "Story3", isEndPage: false),
                SimpleStoryPage(titleKey: "", textKey: "shy_text_2", imageName: "Story4", isEndPage: true)
            ],
            audioFileName: "BoyShy"
        ) {
            QuizView(scenarioIndex: 1)
        }
    }
}

// MARK: - Preview
#Preview {
    ShyStory()
}
