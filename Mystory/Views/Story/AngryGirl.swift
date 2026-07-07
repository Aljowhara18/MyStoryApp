
import SwiftUI

struct AngryGirl: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "Angry_title", textKey: "Dialouge_1", imageName: "AngryGirl1", audioStartTime: 0, isEndPage: false),
                SimpleStoryPage(titleKey: "  ", textKey: "Dialouge_2", imageName: "AngryGirl2", audioStartTime: 7, isEndPage: true)
            ],
            audioFileName: "GirlAngry",
            style: StoryStyle(
                titleFontSize: 25,
                titleTopPadding: 24,
                titleBottomPadding: 6,
                noTitleSpacerHeight: 8,
                bottomArrowsHorizontalPadding: nil,
                bottomArrowsBottomPadding: 25
            )
        ) {
            SaraQuiz4()
        }
    }
}

// MARK: - Preview
#Preview {
    AngryGirl()
}
