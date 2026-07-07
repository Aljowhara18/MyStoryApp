
import SwiftUI

// MARK: - Home Screen
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    let character: CharacterType

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 32) {
                NavigationLink {
                    CategoryView(character: character)
                } label: {
                    PrimaryMenuButton(title: viewModel.menuTitles[0])
                }

                NavigationLink {
                    CreateStory(character: character)
                } label: {
                    PrimaryMenuButton(title: viewModel.menuTitles[1])
                }
            }
            .padding(.top, 80)

            Spacer()

            Image(character.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 199, height: 449)
                .padding(.bottom, -120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.screenBackground
                .ignoresSafeArea()
        )
    }
}

// MARK: - Previews
#Preview("Home - Boy") {
    NavigationStack {
        HomeView(character: .boy)
    }
}

#Preview("Home - Girl") {
    NavigationStack {
        HomeView(character: .girl)
    }
}
