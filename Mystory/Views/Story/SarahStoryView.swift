
import SwiftUI

struct SarahStoryView: View {
    var body: some View {
        BaseStoryView(
            stories: [
                SimpleStoryPage(titleKey: "story1_title", textKey: "story1_text", imageName: "SarahStory1", isEndPage: false),
                SimpleStoryPage(titleKey: "", textKey: "story2_text", imageName: "SarahStory2", isEndPage: true)
            ],
            audioFileName: "GirlPlay",
            style: StoryStyle(
                titleFontSize: 25,
                titleTopPadding: 0,
                titleBottomPadding: 0,
                noTitleSpacerHeight: 0,
                showsTopBackButton: true,
                bottomArrowsHorizontalPadding: nil,
                bottomArrowsBottomPadding: 25
            )
        ) {
            SaraQuiz()
        }
    }
}

// MARK: - Preview
#Preview {
    SarahStoryView()
}
