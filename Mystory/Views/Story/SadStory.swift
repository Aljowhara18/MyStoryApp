
import SwiftUI

struct SadStory: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "sad_title", textKey: "sad_text_1", imageName: "Story7", isEndPage: false),
                SimpleStoryPage(titleKey: "", textKey: "sad_text_2", imageName: "Story8", isEndPage: true)
            ],
            audioFileName: "BoySad"
        ) {
            QuizView(scenarioIndex: 3)
        }
    }
}

// MARK: - Preview
#Preview {
    SadStory()
}
