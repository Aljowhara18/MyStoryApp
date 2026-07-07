
import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories: [EmotionCategory] = [
        EmotionCategory(key: "category_play"),
        EmotionCategory(key: "category_angry"),
        EmotionCategory(key: "category_friend_sad"),
        EmotionCategory(key: "category_shy")
    ]
}
