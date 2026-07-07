import SwiftUI

struct StoryEditorView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: ((Story) -> Void)? = nil

    struct Segment: Identifiable, Hashable {
        let id = UUID()
        var text: String = ""
        var image: UIImage? = nil
    }

    @State private var title: String = ""
    @State private var segments: [Segment] = [Segment()]
    @State private var currentIndex: Int = 0
    @State private var showImagePicker = false
    @State private var showImageOptions = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @FocusState private var isTextEditorFocused: Bool

    private let maxCharacters = 50

    private var currentSegment: Binding<Segment> {
        Binding(
            get: { segments[currentIndex] },
            set: { segments[currentIndex] = $0 }
        )
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.screenBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                topBar
                imagePicker
                titleField
                textInput
                Spacer().onTapGesture { hideKeyboard() }
                pageNavigator
                saveButton
            }
        }
        .onTapGesture { hideKeyboard() }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("تم") { hideKeyboard() }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
            }
        }
        .confirmationDialog("اختر مصدر الصورة", isPresented: $showImageOptions) {
            Button("الكاميرا") {
                imageSourceType = .camera
                showImagePicker = true
            }
            Button("المعرض") {
                imageSourceType = .photoLibrary
                showImagePicker = true
            }
            Button("إلغاء", role: .cancel) {}
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(
                image: Binding(
                    get: { currentSegment.wrappedValue.image },
                    set: { currentSegment.wrappedValue.image = $0 }
                ),
                sourceType: imageSourceType
            )
        }
    }

    // MARK: - Top Bar
    private var topBar: some View {
        ZStack {
            HStack {
                Button(action: { hideKeyboard(); dismiss() }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                }
                .accessibilityLabel(NSLocalizedString("back_button", comment: ""))
                Spacer()
            }
            Text(NSLocalizedString("story_title", comment: ""))
                .font(.system(size: 17, weight: .semibold))
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
    }

    // MARK: - Image Picker
    private var imagePicker: some View {
        Button(action: { hideKeyboard(); showImageOptions = true }) {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                    .frame(height: 240)

                if let image = currentSegment.wrappedValue.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray.opacity(0.7))
                        Text(NSLocalizedString("add_image", comment: ""))
                            .font(.system(size: 14))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                }
            }
        }
        .padding(.horizontal, 32)
    }

    private var titleField: some View {
        TextField(NSLocalizedString("enter_title", comment: ""), text: $title)
            .font(.system(size: 22, weight: .semibold))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            .onSubmit { hideKeyboard() }
    }

    private var textInput: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topLeading) {
                TextEditor(
                    text: Binding(
                        get: { currentSegment.wrappedValue.text },
                        set: { newValue in
                            var updated = newValue
                            if updated.count > maxCharacters {
                                updated = String(updated.prefix(maxCharacters))
                            }
                            currentSegment.wrappedValue.text = updated
                        }
                    )
                )
                .font(.system(size: 16))
                .lineSpacing(6)
                .frame(height: 120)
                .padding(.horizontal, 24)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .focused($isTextEditorFocused)

                if currentSegment.wrappedValue.text.isEmpty {
                    Text("\(NSLocalizedString("write_page", comment: "")) (\(maxCharacters) max)…")
                        .font(.system(size: 16))
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 32)
                        .padding(.top, 14)
                        .allowsHitTesting(false)
                }
            }

            HStack {
                Spacer()
                Text("\(currentSegment.wrappedValue.text.count)/\(maxCharacters)")
                    .font(.system(size: 11))
                    .foregroundColor(currentSegment.wrappedValue.text.count >= maxCharacters ? .red : .gray)
                    .padding(.trailing, 32)
            }
        }
    }

    // MARK: - Page Navigator
    private var pageNavigator: some View {
        HStack(spacing: 24) {
            Button(action: { hideKeyboard(); goToPreviousPage() }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 18))
            }
            .accessibilityLabel(NSLocalizedString("page_previous", comment: ""))
            .disabled(currentIndex == 0)
            .opacity(currentIndex == 0 ? 0.3 : 1)

            Text("\(NSLocalizedString("page", comment: "")) \(currentIndex + 1) \(NSLocalizedString("of", comment: "")) \(segments.count)")
                .font(.system(size: 14))
                .foregroundColor(.gray)

            Button(action: { hideKeyboard(); goToNextPage() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
            }
            .accessibilityLabel(NSLocalizedString("page_next", comment: ""))
            .disabled(currentSegment.wrappedValue.text.count < maxCharacters)
            .opacity(currentSegment.wrappedValue.text.count < maxCharacters ? 0.3 : 1)
        }
    }

    private var saveButton: some View {
        Button(action: { hideKeyboard(); saveStory() }) {
            Text(NSLocalizedString("save_story", comment: ""))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .shadow(color: Color.navyblue.opacity(0.30), radius: 8, x: 0, y: 4)
                )
        }
        .buttonStyle(.plain)
        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty || allTextIsEmpty)
        .opacity(title.trimmingCharacters(in: .whitespaces).isEmpty || allTextIsEmpty ? 0.4 : 1.0)
        .padding(.bottom, 24)
    }

    private var allTextIsEmpty: Bool {
        segments.allSatisfy { $0.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    // MARK: - Page Navigation
    private func goToNextPage() {
        if currentIndex == segments.count - 1 {
            segments.append(Segment())
        }
        currentIndex += 1
    }

    private func goToPreviousPage() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    private func saveStory() {
        var final = Story()
        final.title = title
        final.pages = segments.map { $0.text }.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        final.text = final.pages.joined(separator: " ")
        if let firstImage = segments.first(where: { $0.image != nil })?.image {
            final.image = firstImage
        }
        onSave?(final)
        dismiss()
    }

    private func hideKeyboard() {
        isTextEditorFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    NavigationStack {
        StoryEditorView()
    }
}
