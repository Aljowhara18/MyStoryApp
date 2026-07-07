
import SwiftUI

struct WordsFlowView: View {
    let text: String
    let highlightedWordIndex: Int

    var body: some View {
        let words = text.components(separatedBy: .whitespacesAndNewlines)

        Text(words.enumerated().map { index, word in
            AttributedString(word + (index < words.count - 1 ? " " : ""))
        }.enumerated().map { index, attr in
            var copy = attr
            if index == highlightedWordIndex {
                copy.backgroundColor = .yellow
            }
            return copy
        }.reduce(into: AttributedString()) { $0.append($1) })
        .font(.system(size: 22))
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 8)
        .animation(.easeInOut(duration: 0.15), value: highlightedWordIndex)
    }
}
