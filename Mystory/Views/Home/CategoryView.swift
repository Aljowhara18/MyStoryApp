
import SwiftUI

// MARK: - Category Screen
struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()

    let character: CharacterType

    var body: some View {
        ZStack {
            Color.screenBackground
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text(NSLocalizedString("category_screen_title", comment: "Choose story title"))
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 100)

                VStack(spacing: 24) {
                    ForEach(viewModel.categories) { category in

                        let displayedTitle: String = {
                            if category.key == "category_friend_sad" && character == .girl {
                                return NSLocalizedString("category_friend_sad_girl",
                                                         comment: "Sad friend (girl)")
                            } else {
                                return category.title
                            }
                        }()

                        NavigationLink {
                            switch category.key {
                            case "category_play":
                                if character == .boy {
                                    PlayStory()
                                } else {
                                    SarahStoryView()
                                }
                            case "category_angry":
                                if character == .boy {
                                    AngryStory()
                                } else {
                                    AngryGirl()
                                }
                            case "category_friend_sad":
                                if character == .boy {
                                    SadStory()
                                } else {
                                    SadGirl()
                                }
                            case "category_shy":
                                if character == .boy {
                                    ShyStory()
                                } else {
                                    ShyGirl()
                                }
                            default:
                                StoryView(title: category.title)
                            }
                        } label: {
                            Text(displayedTitle)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                                .frame(width: 279, height: 90)
                                .background(
                                    RoundedRectangle(cornerRadius: 34)
                                        .fill(Color.white)
                                        .shadow(
                                            color: Color.cardShadow.opacity(0.3),
                                            radius: 13,
                                            x: 0,
                                            y: 0
                                        )
                                )
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 21)

                Spacer()

                Image(character.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 178, height: 448)
                    .padding(.bottom, -130)
            }
        }
    }
}

// MARK: - Previews
#Preview("Category - Boy") {
    NavigationStack {
        CategoryView(character: .boy)
    }
}

#Preview("Category - Girl") {
    NavigationStack {
        CategoryView(character: .girl)
    }
}
