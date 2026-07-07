
import SwiftUI

// MARK: - Story Screen (Generic)
struct StoryView: View {
    let title: String

    var body: some View {
        VStack(spacing: 24) {
            Text(title)
                .font(.system(size: 28, weight: .bold))

            Text(NSLocalizedString("story_generic_body", comment: "Generic story body"))
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.screenBackground
                .ignoresSafeArea()
        )
    }
}
