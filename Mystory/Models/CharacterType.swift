
import SwiftUI

// MARK: - Character Type (Boy / Girl)
enum CharacterType {
    case boy
    case girl

    var imageName: String {
        switch self {
        case .boy:
            return "waving boy"
        case .girl:
            return "waving girl"
        }
    }
}
