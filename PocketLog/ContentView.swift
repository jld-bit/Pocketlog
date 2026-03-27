import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = KeypadViewModel()

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    private let keys: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "C", "0", "⌫"]

    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 0)

            Text("$\(viewModel.amountText)")
                .font(.system(size: 64, weight: .black, design: .rounded))
                .foregroundStyle(PocketTheme.cyberOrange)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 24)
                .minimumScaleFactor(0.5)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(keys, id: \.self) { key in
                    Button {
                        handle(key: key)
                    } label: {
                        Text(key)
                            .font(.system(size: 36, weight: .black, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .frame(height: 82)
                            .background(PocketTheme.background)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(PocketTheme.cyberOrange, lineWidth: 2)
                            }
                            .foregroundStyle(PocketTheme.cyberOrange)
                    }
                    .buttonStyle(BouncyButtonStyle())
                }
            }
            .padding(.horizontal, 24)

            Button {
                makeImpact()
                viewModel.save(using: modelContext)
            } label: {
                Text("LOG AMOUNT")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .frame(height: 86)
                    .background(PocketTheme.cyberOrange)
                    .foregroundStyle(PocketTheme.background)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .padding(.horizontal, 24)
            }
            .buttonStyle(BouncyButtonStyle())

            Spacer(minLength: 12)
        }
        .background(PocketTheme.background.ignoresSafeArea())
    }

    private func handle(key: String) {
        makeImpact()
        switch key {
        case "C":
            viewModel.clear()
        case "⌫":
            viewModel.backspace()
        default:
            viewModel.append(key)
        }
    }

    private func makeImpact() {
        #if canImport(UIKit)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        #endif
    }
}
