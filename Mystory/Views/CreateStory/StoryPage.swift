import SwiftUI

struct StoryPage: View {
    let story: Story
    @Environment(\.dismiss) var dismiss
    @State private var currentPageIndex = 0

    private var displayPages: [String] {
        if story.pages.isEmpty {
            return [story.text]
        }
        return story.pages
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                Color("Baige")
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    if let img = story.image {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height * 0.5)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } else {
                        Color("Baige")
                            .frame(height: geo.size.height * 0.5)
                            .ignoresSafeArea(edges: .top)
                    }
                    Spacer(minLength: 0)
                }

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: geo.size.height * 0.30)

                    ZStack(alignment: .top) {
                        WaveShape()
                            .fill(Color.white)
                            .frame(height: geo.size.height * 0.9)

                        VStack(spacing: 16) {
                            Spacer().frame(height: 60)

                            Text(story.title)
                                .font(.system(size: 22, weight: .bold))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 24)

                            TabView(selection: $currentPageIndex) {
                                ForEach(0..<displayPages.count, id: \.self) { index in
                                    ScrollView {
                                        Text(displayPages[index])
                                            .font(.system(size: 17))
                                            .lineSpacing(6)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 24)
                                            .padding(.bottom, 150)
                                    }
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))

                            Spacer()
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)

                // MARK: - Navigation Controls
                VStack {
                    Spacer()

                    HStack {
                        Button(action: {
                            if currentPageIndex > 0 {
                                currentPageIndex -= 1
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 35))
                                .foregroundColor(currentPageIndex == 0 ? .gray : .black)
                        }
                        .accessibilityLabel(NSLocalizedString("page_previous", comment: ""))

                        Spacer()

                        Button(action: { dismiss() }) {
                            Text("انتهيت")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
                                )
                        }

                        Spacer()

                        Button(action: {
                            if currentPageIndex < displayPages.count - 1 {
                                currentPageIndex += 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 35))
                                .foregroundColor(currentPageIndex == displayPages.count - 1 ? .gray : .black)
                        }
                        .accessibilityLabel(NSLocalizedString("page_next", comment: ""))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 165)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    var previewStory = Story()
    previewStory.title = "أريد أن ألعب"
    previewStory.pages = ["كان خالد يقف في ساحة المدرسة", "يشاهد الأطفال وهم يلعبون مع بعض"]
    previewStory.image = UIImage(named: "girl")

    return NavigationStack {
        StoryPage(story: previewStory)
    }
}
