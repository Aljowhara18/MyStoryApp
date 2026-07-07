
import SwiftUI

struct SadGirl: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "Sad_title", textKey: "Dialouge.1", imageName: "SadGirl1", audioStartTime: 0, isEndPage: false),
                SimpleStoryPage(titleKey: "  ", textKey: "Dialouge.2", imageName: "SadGirl2", audioStartTime: 7, isEndPage: true)
            ],
            audioFileName: "GirlSad",
            style: StoryStyle(
                titleFontSize: 25,
                titleTopPadding: 24,
                titleBottomPadding: 6,
                noTitleSpacerHeight: 8,
                bottomArrowsHorizontalPadding: nil,
                bottomArrowsBottomPadding: 25
            )
        ) {
            SaraQuiz3()
        }
    }
}

// MARK: - Preview
#Preview {
    SadGirl()
}
