import Foundation
import SwiftData

@MainActor
final class KeypadViewModel: ObservableObject {
    @Published private(set) var amountText = "0"

    func append(_ value: String) {
        if amountText == "0" {
            amountText = value
        } else {
            amountText += value
        }
    }

    func backspace() {
        guard !amountText.isEmpty else { return }
        amountText.removeLast()
        if amountText.isEmpty {
            amountText = "0"
        }
    }

    func clear() {
        amountText = "0"
    }

    var decimalAmount: Decimal {
        Decimal(string: amountText) ?? .zero
    }

    func save(using context: ModelContext) {
        guard decimalAmount > 0 else { return }
        context.insert(ExpenseLog(amount: decimalAmount))

        do {
            try context.save()
        } catch {
            print("Failed to save quick log: \(error)")
        }

        clear()
        WidgetRefresh.reloadWidgets()
    }
}
