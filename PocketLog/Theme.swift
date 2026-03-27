import SwiftUI

enum PocketTheme {
    static let background = Color.white
    static let cyberOrange = Color(red: 1.0, green: 0.39, blue: 0.0)
}

struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.58), value: configuration.isPressed)
    }
}
