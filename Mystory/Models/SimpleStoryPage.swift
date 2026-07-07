
import SwiftUI

// MARK: - Story Model
struct SimpleStoryPage: Identifiable, Hashable {
    let id = UUID()
    let titleKey: String
    let textKey: String
    let imageName: String
    var audioStartTime: TimeInterval = 0
    var autoStopAfter: TimeInterval? = nil
    let isEndPage: Bool
}
