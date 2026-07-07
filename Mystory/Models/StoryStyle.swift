
import SwiftUI

enum ListenButtonBehavior {
    case toggle
    case disableWhilePlaying
}

struct StoryStyle {
    var titleFontSize: CGFloat = 30
    var contentTopPaddingFraction: CGFloat? = 0.40
    var titleTopPadding: CGFloat = 0
    var titleBottomPadding: CGFloat = 0
    var noTitleSpacerHeight: CGFloat = 20
    var extraSpacerOnLastPage: CGFloat? = nil
    var showsTopBackButton: Bool = true
    var useWordHighlighting: Bool = false
    var listenButtonBehavior: ListenButtonBehavior = .toggle
    var bottomArrowsHorizontalPadding: CGFloat? = 9
    var bottomArrowsBottomPadding: CGFloat = 90
}
