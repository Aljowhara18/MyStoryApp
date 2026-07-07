
import SwiftUI
import AVFoundation

// MARK: - Base Story View
struct BaseStoryView<Destination: View>: View {

    let stories: [SimpleStoryPage]
    let audioFileName: String
    var style: StoryStyle = StoryStyle()
    let destination: () -> Destination

    init(stories: [SimpleStoryPage], audioFileName: String, style: StoryStyle = StoryStyle(), @ViewBuilder destination: @escaping () -> Destination) {
        self.stories = stories
        self.audioFileName = audioFileName
        self.style = style
        self.destination = destination
    }

    @Environment(\.dismiss) private var dismiss

    @State private var step = 0
    @State private var isReading = false
    @State private var navigateToNext = false
    @GestureState private var dragOffset: CGFloat = 0

    @State private var audioPlayer: AVAudioPlayer?
    @State private var highlightedWordIndex: Int = -1
    @State private var highlightTimer: Timer?
    @State private var autoStopWorkItem: DispatchWorkItem?

    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(stories[step].imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    if style.showsTopBackButton {
                        HStack {
                            Button(action: {
                                stopAll()
                                dismiss()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 28))
                                    .foregroundColor(.black)
                                    .padding(12)
                                    .background(Color.white.opacity(0.75))
                                    .clipShape(Circle())
                            }
                            .accessibilityLabel(NSLocalizedString("back_button", comment: ""))
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.top, 10)
                    }

                    contentBlock
                        .offset(x: dragOffset)
                        .gesture(pagingGesture)
                        .modifier(TopOffsetModifier(fraction: style.contentTopPaddingFraction, height: geo.size.height))

                    Spacer()

                    arrowsRow
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationDestination(isPresented: $navigateToNext) {
            destination()
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Content Block
    private var contentBlock: some View {
        VStack(alignment: .leading, spacing: 28) {

            Spacer().frame(height: style.noTitleSpacerHeight)

            if !stories[step].titleKey.isEmpty {
                Text(LocalizedStringKey(stories[step].titleKey))
                    .font(.system(size: style.titleFontSize, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, style.titleTopPadding)
                    .padding(.bottom, style.titleBottomPadding)
            }

            if style.extraSpacerOnLastPage != nil && stories[step].isEndPage {
                Spacer().frame(height: style.extraSpacerOnLastPage!)
            }

            if style.useWordHighlighting {
                WordsFlowView(
                    text: NSLocalizedString(stories[step].textKey, comment: ""),
                    highlightedWordIndex: highlightedWordIndex
                )
            } else {
                Text(LocalizedStringKey(stories[step].textKey))
                    .font(.system(size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                Button {
                    handleListenTap()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: isReading ? "pause.fill" : "speaker.wave.2.fill")
                        Text(isReading ? NSLocalizedString("pause_btn", comment: "") : NSLocalizedString("listen_btn", comment: ""))
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(14)
                }
                .disabled(style.listenButtonBehavior == .disableWhilePlaying && isReading)

                Spacer()
            }

            if stories[step].isEndPage {
                Button {
                    stopAll()
                    navigateToNext = true
                } label: {
                    Text(NSLocalizedString("finish_btn", comment: ""))
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 30)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(14)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Arrows + Dots
    private var arrowsRow: some View {
        HStack {
            Button {
                stopAll()
                goBack()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 35))
                    .foregroundColor(step == 0 ? .gray : .black)
            }
            .disabled(step == 0)
            .accessibilityLabel(NSLocalizedString("page_previous", comment: ""))

            Spacer()

            HStack(spacing: 10) {
                ForEach(0..<stories.count, id: \.self) { index in
                    Circle()
                        .fill(index == step ? Color.black : Color.gray.opacity(0.5))
                        .frame(
                            width: index == step ? 14 : 10,
                            height: index == step ? 14 : 10
                        )
                }
            }

            Spacer()

            Button {
                stopAll()
                goNext()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 35))
                    .foregroundColor(step == stories.count - 1 ? .gray : .black)
            }
            .disabled(step == stories.count - 1)
            .accessibilityLabel(NSLocalizedString("page_next", comment: ""))
        }
        .padding(.horizontal, style.bottomArrowsHorizontalPadding ?? 16)
        .padding(.bottom, style.bottomArrowsBottomPadding)
    }

    private var pagingGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                stopAll()
                if value.translation.width < -50 { goNext() }
                else if value.translation.width > 50 { goBack() }
            }
    }

    // MARK: - Navigation
    func goNext() {
        if step < stories.count - 1 {
            step += 1
            reset()
        }
    }

    func goBack() {
        if step > 0 {
            step -= 1
            reset()
        }
    }

    func reset() {
        isReading = false
        highlightedWordIndex = -1
        highlightTimer?.invalidate()
        stopAudio()
    }

    // MARK: - Listen Button
    private func handleListenTap() {
        switch style.listenButtonBehavior {
        case .toggle:
            toggleReading()
        case .disableWhilePlaying:
            if !isReading {
                if style.useWordHighlighting {
                    startHighlighting()
                }
                playAudio()
            }
        }
    }

    func toggleReading() {
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
                isReading = false
            } else {
                player.play()
                isReading = true
            }
        } else {
            playAudio()
            isReading = true
        }
    }

    // MARK: - Word Highlighting (shy scenario)
    private func startHighlighting() {
        let words = NSLocalizedString(stories[step].textKey, comment: "")
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }

        guard !words.isEmpty else { return }
        isReading = true
        highlightedWordIndex = 0
        var current = 0

        highlightTimer?.invalidate()
        highlightTimer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { timer in
            current += 1
            if current >= words.count {
                timer.invalidate()
                isReading = false
                highlightedWordIndex = -1
            } else {
                highlightedWordIndex = current
            }
        }
    }

    // MARK: - Audio
    func playAudio() {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {
            print("❌ Audio not found:", audioFileName)
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.currentTime = stories[step].audioStartTime
            audioPlayer?.play()

            autoStopWorkItem?.cancel()
            if let autoStopAfter = stories[step].autoStopAfter {
                let workItem = DispatchWorkItem { [self] in
                    audioPlayer?.stop()
                }
                autoStopWorkItem = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + autoStopAfter, execute: workItem)
            }
        } catch {
            print("❌ Audio error:", error.localizedDescription)
        }
    }

    func stopAudio() {
        autoStopWorkItem?.cancel()
        audioPlayer?.stop()
        audioPlayer = nil
        isReading = false
    }

    func stopAll() {
        highlightTimer?.invalidate()
        stopAudio()
    }
}

// MARK: - Top Offset Modifier
private struct TopOffsetModifier: ViewModifier {
    let fraction: CGFloat?
    let height: CGFloat

    func body(content: Content) -> some View {
        if let fraction {
            content.padding(.top, height * fraction)
        } else {
            content
        }
    }
}
