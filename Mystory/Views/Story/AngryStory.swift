
import SwiftUI

struct AngryStory: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "angry_title", textKey: "angry_text_1", imageName: "Story5", isEndPage: false),
                SimpleStoryPage(titleKey: "", textKey: "angry_text_2", imageName: "Story6", isEndPage: true)
            ],
            audioFileName: "BoyAngry"
        ) {
            QuizView(scenarioIndex: 2)
        }
    }
}

// MARK: - Preview
#Preview {
    AngryStory()
}
