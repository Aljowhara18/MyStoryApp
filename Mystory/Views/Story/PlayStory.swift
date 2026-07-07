
import SwiftUI

struct PlayStory: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "play_title", textKey: "play_text_1", imageName: "Story1", isEndPage: false),
                SimpleStoryPage(titleKey: "", textKey: "play_text_2", imageName: "Story2", isEndPage: true)
            ],
            audioFileName: "BoyPlay"
        ) {
            QuizView(scenarioIndex: 0)
        }
    }
}

// MARK: - Preview
#Preview {
    PlayStory()
}
