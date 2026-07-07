
import SwiftUI

// MARK: - Shared Button
struct PrimaryMenuButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.black)
            .frame(width: 199, height: 90)
            .background(
                Capsule()
                    .fill(Color.white)
                    .shadow(
                        color: Color(red: 0.10, green: 0.56, blue: 1.0).opacity(0.3),
                        radius: 16,
                        x: 0,
                        y: 0
                    )
            )
    }
}
