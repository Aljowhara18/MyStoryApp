
import SwiftUI

struct ShyGirl: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "Shy_title", textKey: "Dialouge1", imageName: "ShyGirl1", audioStartTime: 0, autoStopAfter: 6, isEndPage: false),
                SimpleStoryPage(titleKey: "  ", textKey: "Dialouge2", imageName: "ShyGirl2", audioStartTime: 7, autoStopAfter: 16, isEndPage: true)
            ],
            audioFileName: "GirlShy",
            style: StoryStyle(
                titleFontSize: 25,
                titleTopPadding: 24,
                titleBottomPadding: 6,
                noTitleSpacerHeight: 10,
                extraSpacerOnLastPage: 12,
                useWordHighlighting: true,
                listenButtonBehavior: .disableWhilePlaying,
                bottomArrowsHorizontalPadding: nil,
                bottomArrowsBottomPadding: 25
            )
        ) {
            SaraQuiz2()
        }
    }
}

// MARK: - Preview
#Preview {
    ShyGirl()
}
