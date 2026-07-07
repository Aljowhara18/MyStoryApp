import SwiftUI

struct CreateStory: View {
    @Environment(\.dismiss) var dismiss
    let character: CharacterType

    @AppStorage private var savedStoriesData: Data
    @State private var showEditor = false
    @State private var editingStory: Story?
    @State private var stories: [Story] = []
    @State private var selectedStory: Story?

    init(character: CharacterType) {
        self.character = character
        let key = character == .boy ? "saved_stories_boy" : "saved_stories_girl"
        _savedStoriesData = AppStorage(wrappedValue: Data(), key)
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.screenBackground
                .ignoresSafeArea()

            VStack(alignment: .trailing, spacing: 0) {

                HStack {
                    Text("انشئ قصة")
                        .font(.system(size: 34, weight: .bold))

                    Spacer()

                    Button(action: {
                        editingStory = nil
                        showEditor = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .accessibilityLabel(NSLocalizedString("new_story_button", comment: ""))
                }
                .padding(.horizontal, 29)
                .padding(.top, 30)

                if stories.isEmpty {
                    Spacer()
                    Text("لا توجد قصص بعد، اضغط على + لإنشاء قصة جديدة")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            ForEach(stories) { story in
                                Button(action: {
                                    selectedStory = story
                                }) {
                                    Text(story.title.isEmpty ? "قصة بدون عنوان" : story.title)
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 90)
                                        .background(
                                            RoundedRectangle(cornerRadius: 32)
                                                .fill(Color.white)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 32)
                                                        .stroke(Color.navyblue.opacity(0.3), lineWidth: 2)
                                                )
                                                .shadow(
                                                    color: Color.navyblue.opacity(0.30),
                                                    radius: 12,
                                                    x: 0,
                                                    y: 8
                                                )
                                        )
                                }
                                .contextMenu {
                                    Button(role: .destructive, action: {
                                        deleteStory(story)
                                    }) {
                                        Label("حذف", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 40)
                        .padding(.bottom, 24)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            StoryEditorView { newStory in
                if let editing = editingStory, let idx = stories.firstIndex(where: { $0.id == editing.id }) {
                    var updated = newStory
                    updated.id = editing.id
                    stories[idx] = updated
                } else {
                    stories.append(newStory)
                }
                saveStories()
                editingStory = nil
            }
        }
        .fullScreenCover(item: $selectedStory) { story in
            StoryPage(story: story)
        }
        .onAppear {
            loadStories()
        }
    }

    // MARK: - Storage
    private func deleteStory(_ story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories.remove(at: index)
            saveStories()
        }
    }

    private func loadStories() {
        if let decoded = try? JSONDecoder().decode([Story].self, from: savedStoriesData) {
            stories = decoded
        }
    }

    private func saveStories() {
        if let encoded = try? JSONEncoder().encode(stories) {
            savedStoriesData = encoded
        }
    }
}

#Preview {
    NavigationStack {
        CreateStory(character: .boy)
    }
}
