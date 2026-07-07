import SwiftUI

struct Story: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String = ""
    var text: String = ""  // نخليه للتوافق
    var pages: [String] = []  // ← أضف هذا
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }

    private var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case id, title, text, pages, imageData
    }
}
