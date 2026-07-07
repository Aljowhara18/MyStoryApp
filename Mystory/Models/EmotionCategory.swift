
import Foundation

struct EmotionCategory: Identifiable {
    let id = UUID()
    let key: String

    var title: String {
        NSLocalizedString(key, comment: "Category title")
    }
}
